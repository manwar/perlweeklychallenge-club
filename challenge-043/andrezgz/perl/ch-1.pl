#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-043/
# Task #1
# Olympic Rings
# There are 5 rings in the Olympic Logo as shown below.
# They are color coded as in Blue, Black, Red, Yellow and Green.
#
# We have allocated some numbers to these rings as below:
#
# Blue: 8
# Yellow: 7
# Green: 5
# Red: 9
# The Black ring is empty currently.
# You are given the numbers 1, 2, 3, 4 and 6.
# Write a script to place these numbers in the rings so that
# the sum of numbers in each ring is exactly 11.

use strict;
use warnings;

my %values = (
    Red => 9,
    Green => 5,
    Yellow => 7,
    Blue => 8,
);

my %numbers = map {$_ => 1} (1,2,3,4,6);

# each ring components with unknown value at the end
my @rings_components = (
    ['Red','RedGreen'],
    ['Green','RedGreen','GreenBlack'],
    ['Blue','YellowBlue'],
    ['Yellow','YellowBlue','BlackYellow'],
    ['GreenBlack','BlackYellow','Black']
);

foreach my $ring (@rings_components) {
    my $internal_sum = 11;
    foreach my $c (@$ring){
        $values{$c} = $internal_sum unless defined $values{$c};
        $internal_sum -= $values{$c};
    }
}

printf "%s => %d\n",$_,$values{$_} for sort keys %values;

__END__

./ch-1.pl
Black => 6
BlackYellow => 1
Blue => 8
Green => 5
GreenBlack => 4
Red => 9
RedGreen => 2
Yellow => 7
YellowBlue => 3
