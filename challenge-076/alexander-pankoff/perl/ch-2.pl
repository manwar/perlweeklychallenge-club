#!/usr/bin/env perl
use strict;
use warnings;
use autodie;
use feature qw(signatures say);
no warnings qw(experimental::signatures);

use FindBin;
use List::Util qw(any none);

my ( $gridfile, $dictfile ) = @ARGV;

$gridfile //= $FindBin::RealBin . '/grid.txt';
$dictfile //= $FindBin::RealBin . '/dict.txt';

my $dict = read_dict( $dictfile );
my $grid = read_grid( $gridfile );

my %checks = (
    positive_diagonals => [ diagonals( 'positive' ) ],
    negative_diagonals => [ diagonals() ],
    horizontal         => $grid,
    vertical           => [
        map {
            my $index = $_;
            [ map { $_->[$index] } @$grid ]
        } 0 .. $#{ $grid->[0] }
    ]
);

my @out;
for my $check ( keys %checks ) {
    for my $pos ( 0 .. $#{ $checks{$check} } ) {
        my $line_chars     = $checks{$check}->[$pos];
        my $forwards_line  = join( '', @$line_chars );
        my $backwards_line = join( '', reverse @$line_chars );
        my %lines          = ( forwards => $forwards_line, backwards => $backwards_line );
        for my $line ( keys %lines ) {
            my @res = check_line( $lines{$line}, $dict );
            push @out, @res;
            say "found " . join( ", ", @res ) . " $line in $check $pos" if $ENV{DEBUG} && @res;
        }
    }
}

say join( "\n", @out );
say 'Found ' . @out . ' entries';

sub diagonals {
    my ( $positive ) = @_;

    my $height = $#{$grid};
    my $width  = $#{ $grid->[0] };

    my @start_points = map { [ $_, $positive ? 0 : $width ] } 0 .. $height - 1;
    push @start_points, map { [ $height, $_ ] } $positive ? 0 .. $width : reverse 0 .. $width;

    my @diags;
    for my $point ( @start_points ) {
        my @diag;
        my ( $row, $col ) = @$point;
        while ( $row >= 0 && ( $positive ? $col <= $width : $col >= 0 ) ) {
            push @diag, $grid->[$row][$col];
            $row--;
            $positive ? $col++ : $col--;
        }
        push @diags, \@diag;
    }

    return @diags;
}

sub check_line ( $line, $dict ) {
    grep { $line =~ m/$_/i } @$dict;
}

sub read_dict($filename) {
    open( my $fh, '<', $filename );
    chomp( my @out = <$fh> );
    return \@out;
}

sub read_grid($filename) {
    open( my $fh, '<', $filename );
    chomp( my @lines = <$fh> );
    return [ map { [ split( ' ', $_ ) ] } @lines ];
}

sub usage() {
    say <<"END";
$0 [GRIDFILE] [DICTFILE]

  This programm takes two file names. A GRIDFILE containing a grid of
  characters and a DICTFILE that contains a list of words.
  It will print out all words from DICTFILE that can be found in the grid by
  looking both orthogonally and diagonally, backwards as well as forwards.

END
}
