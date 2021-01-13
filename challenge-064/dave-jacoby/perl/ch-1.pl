#!/usr/bin/env perl

# USAGE: ch-1.pl [-u] [file ...]

use strict;
use warnings;
use utf8;
use feature qw{ fc postderef say signatures state switch };
no warnings qw{ experimental };

use List::Util qw{sum};

my $matrix = [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ], ];

my @solutions = solve_matrix($matrix);

my ($sol) = sort { sum( $a->@*) <=> sum( $b->@* )} @solutions;

say join ' -> ', $sol->@*;

sub solve_matrix ( $matrix, $x = 0, $y = 0, $path = [] ) {
    my @output;
    my @path = $path->@*;
    my $endx = -1 + scalar $matrix->@*;
    my $endy = -1 + scalar $matrix->[0]->@*;
    return if $x > $endx;
    return if $y > $endy;

    push @path, $matrix->[$x][$y];

    return \@path if $x == $endx && $y == $endy;
    push @output, solve_matrix( $matrix, $x,     $y + 1, \@path );    #right
    push @output, solve_matrix( $matrix, $x + 1, $y,     \@path );    #down
    return wantarray ? @output : \@output;
}
