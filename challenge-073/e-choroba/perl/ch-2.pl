#! /usr/bin/perl
use warnings;
use strict;

sub smallest_neighbour {
    my ($arr) = @_;
    my @neighbours = 0;
    my $min = $arr->[0];
    for my $i (1 .. $#$arr) {
        # It seems the minimum must also be less than the current element.
        push @neighbours, $min < $arr->[$i] ? $min : 0;
        $min = $arr->[$i] if $arr->[$i] < $min;
    }
    return \@neighbours
}

use Test::More tests => 2;

is_deeply smallest_neighbour([7, 8, 3, 12, 10]),
    [0, 7, 0, 3, 3];

is_deeply smallest_neighbour([4, 6, 5]),
    [0, 4, 4];
