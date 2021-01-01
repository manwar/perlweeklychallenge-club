#!/usr/bin/env perl
#
# You are given set of co-ordinates @N. Write a script to count maximum points on a straight line when given
# co-ordinates plotted on 2-d plane.

use v5.30;
use warnings;

use Test::More;
use List::Util 'max';

sub maximum_points {
    my @points = @_;

    my %lines = (
        x  => {},
        y  => {},
        d1 => {},
        d2 => {},
    );

    foreach my $point (@points) {
        $lines{x}{$point->[0]}++;
        $lines{y}{$point->[1]}++;
        $lines{d1}{$point->[0] - $point->[1]}++;
        $lines{d2}{$point->[0] + $point->[1]}++;
    }

    my @lines;
    foreach my $hashset (values %lines) {
        push @lines, values %$hashset;
    }

    return max(@lines);
}

is maximum_points([1,1], [2,2], [3,3]), 3, '1st example';
is maximum_points([1,1], [2,2], [3,1], [1,3], [5,3]), 3, '2nd example';
is maximum_points([1,1], [2,1], [3,1], [4,1], [2,2]), 4, 'extra example';

done_testing;