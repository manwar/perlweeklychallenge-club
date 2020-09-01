#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(uniq);
use 5.10.1;

sub _read_grid_file {
    my $grid_file = shift;
    my @grid      = ();

    # Read the file
    open( my $fh, '<', $grid_file ) || die "Cannot open $grid_file: $!";
    while ( my $line = <$fh> ) {
        push @grid, [ map { lc $_ } ( $line =~ /([a-z])/ig ) ];
    }

    # Let's sanity check that all rows are the same length
    my @lengths = uniq map { scalar(@$_) } @grid;

    if ( scalar(@lengths) != 1 ) {
        die 'Mismatched lengths (' . join( ', ', @lengths ) . ")\n";
    }

    return \@grid;
}

sub _read_word_file {
    my $word_file = shift;
    my %word_list = ();

    # Read the file, and add any words entirely made up of the English alphabet
    open( my $fh, '<', $word_file ) || die "Cannot open $word_file: $!";
    while ( my $line = <$fh> ) {
        chomp($line);
        $word_list{ lc $line } = 1
          if $line =~ /^[a-z]{5,}$/i;
    }

    return \%word_list;
}

sub _find_words {
    my ( $grid, $word_list, $row, $col, $delta_row, $delta_col ) = @_;
    my $max_row = $#$grid;
    my $max_col = $#{ $grid->[0] };

    # Start with the stated row and column
    my $cur_row = $row;
    my $cur_col = $col;

    my $word    = '';
    my @matches = ();
    while ( $cur_row >= 0
        and $cur_row <= $max_row
        and $cur_col >= 0
        and $cur_col <= $max_col )
    {
        # Add the letter at this position
        $word .= $grid->[$cur_row][$cur_col];

        # Add the word if it's a real word
        push @matches, $word if $word_list->{$word};

        # Move the pointer in the specified direction
        $cur_row += $delta_row;
        $cur_col += $delta_col;
    }

    return @matches;

}

sub main {
    my ( $grid_file, $word_file ) = @_;

    # Sanity check
    die "Grid file is not specified"                  if !$grid_file;
    die "Word file is not specified"                  if !$word_file;
    die "Grid file does not exist or is not readable" if !-r $grid_file;
    die "Word file does not exist or is not readable" if !-r $word_file;

    # Process the inputs
    my $grid      = _read_grid_file($grid_file);
    my $word_list = _read_word_file($word_file);

#<<<
    my @directions = (
        [  1,  0 ], [ -1, 0 ], [ 0,  1 ], [ 0, -1 ], # Down, Up, Right, Left
        [ -1, -1 ], [ -1, 1 ], [ 1, -1 ], [ 1,  1 ], # UL, UR, DL, DR
    );
#>>>

    # Go throw each row, column and direction to find possible solutions
    my @words = ();
    for my $row ( 0 .. $#$grid ) {
        for my $col ( 0 .. $#{ $grid->[$row] } ) {
            for my $direction (@directions) {
                push @words,
                  _find_words( $grid, $word_list, $row, $col, @$direction );
            }
        }
    }

    say join "\n", sort( uniq(@words) );
}

main(@ARGV);
