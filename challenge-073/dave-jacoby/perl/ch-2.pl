#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use List::Util qw{min};

smallest_neighbour( 7, 8, 3, 12, 10 );
smallest_neighbour( 4, 6, 5 );
smallest_neighbour( map { 1 + int rand 15 } 0 .. 2 + int rand 10 );

sub smallest_neighbour ( @array ) {
    my @output;
    my @left;

    say join "\t", 'INPUT:  ', join ', ', @array;
    while (@array) {
        my $k = shift @array;
        my $l = min grep { $_ < $k } @left;
        push @output, defined $l ? $l : 0;
        push @left, $k;
    }

    say join "\t", 'OUTPUT: ', join ', ', @output;
    say '';
}
