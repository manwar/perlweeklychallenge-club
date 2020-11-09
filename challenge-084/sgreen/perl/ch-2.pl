#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);

use List::Util qw(min);

sub main {
    my @array = ();

    # Process the input
    foreach my $row (@_) {
        $row =~ s/[^01]//g;
        die "Each row must have at least two '0' or '1'\n" if length($row) < 2;
        push @array, [ split //, $row ];
    }

    # Sanity check
    die "You must specify at least two rows\n" if scalar(@array) < 2;
    foreach my $row ( 1 .. $#array ) {
        die "Each row must have the same number of colums\n"
          if scalar( @{ $array[0] } ) != scalar( @{ $array[$row] } );
    }

    my $rows = scalar(@array);
    my $cols = scalar( @{ $array[0] } );

    # Go through each rows and column
    # The top left of a square cannot be on the right or bottom row (hence -2)
    my @squares = ();
    foreach my $row ( 0 .. $rows - 2 ) {
        foreach my $col ( 0 .. $cols - 2 ) {
            # No square if this value is zero
            next if $array[$row][$col] == 0;

            # Find the maximum square size
            my $max_size = min( $cols - $col, $rows - $row );

            for my $size ( 2 .. $max_size ) {
                my $offset = $size - 1;
                if (    $array[$row][ $col + $offset ]
                    and $array[ $row + $offset ][$col]
                    and $array[ $row + $offset ][ $col + $offset ] )
                {
                    push @squares, sprintf "row %d col %d size %d", $row + 1,
                      $col + 1, $size;
                }
            }

        }
    }

    # Display the output
    if ( scalar(@squares) == 0 ) {
        say 'Output: 0';
    }
    else {
        say 'Output: ', scalar(@squares), ' (', join( '; ', @squares ), ')';
    }
}

main(@ARGV);
