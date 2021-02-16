#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental::postderef experimental::signatures };

use List::Util qw{sum};
use JSON;
my $json = JSON->new;
my $p    = JSON->new->pretty->canonical;

my @input;
push @input, [ [1], [ 2, 4 ], [ 6, 4, 9 ], [ 5, 1, 7, 2 ] ];
push @input, [ [3], [ 3, 1 ], [ 5, 2, 3 ], [ 4, 3, 1, 3 ] ];

for my $input (@input) {
    triangle_sum($input);
}

sub triangle_sum ( $input ) {
    my ($short) =
        sort { $a->{sum} <=> $b->{sum} } triangle($input);
    say qq{ sum:  $short->{sum} };
    say q{ path: } . join ' ', $short->{path}->@*;
    for my $i ( $input->@* ) {
        say join ' ', '  ', $i->@*;
    }
    say '';
}

sub triangle ( $input, $x = 0, $y = 0, @path ) {
    my @output;

    # if not a leaf, go left and right
    if ( defined $input->[$x][$y] ) {
        push @output, triangle( $input, $x + 1, $y,     @path, $y );
        push @output, triangle( $input, $x + 1, $y + 1, @path, $y );
    }

    # if a leaf, find the sum, find the path, and return
    else {
        my @ind = map     { $path[$_] } 0 .. $x - 1;
        my $sum = sum map { $input->[$_][ $path[$_] ] } 0 .. $x - 1;
        push @output, { sum => $sum, path => \@ind, };
    }
    return @output;
}
