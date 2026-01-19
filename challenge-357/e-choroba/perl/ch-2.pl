#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use Math::Prime::Util qw{ gcd };


sub unique_fraction_generator($int) {
    my @fractions;
    for my $numerator (1 .. $int) {
        for my $denominator (1 .. $int) {
            next if gcd($numerator, $denominator) > 1 && $denominator != 1;

            push @fractions, [$numerator, $denominator,
                              $numerator / $denominator];
        }
    }
    return map "$_->[0]/$_->[1]", sort { $a->[2] <=> $b->[2] } @fractions
}

use Test2::V0;
plan(5);

is [unique_fraction_generator(3)], [qw[ 1/3 1/2 2/3 1/1 3/2 2/1 3/1 ]],
    'Example 1';

is [unique_fraction_generator(4)], [qw[ 1/4 1/3 1/2 2/3 3/4 1/1 4/3 3/2 2/1 3/1
                                        4/1 ]],
    'Example 2';

is [unique_fraction_generator(1)], [qw[ 1/1 ]],
    'Example 3';

is [unique_fraction_generator(6)], [qw[ 1/6 1/5 1/4 1/3 2/5 1/2 3/5 2/3 3/4 4/5
                                        5/6 1/1 6/5 5/4 4/3 3/2 5/3 2/1 5/2 3/1
                                        4/1 5/1 6/1]],
    'Example 4';

is [unique_fraction_generator(5)], [qw[ 1/5 1/4 1/3 2/5 1/2 3/5 2/3 3/4 4/5 1/1
                                        5/4 4/3 3/2 5/3 2/1 5/2 3/1 4/1 5/1]],
    'Example 5';
