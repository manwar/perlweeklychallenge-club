#!/usr/bin/env raku

#
# Perl Weekly Challenge - 071
#
# Task #1: Peak Elements
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-071
#

use Test;

my %test-cases = (
    'test case 1' => {
        in  => [19, 8, 22, 11, 50, 34, 39, 48, 12, 33],
        out => [19, 22, 50, 48, 33],
    },
    'test case 2' => {
        in  => [26, 39, 23, 16, 30, 4, 49, 42, 12, 14],
        out => [39, 30, 49, 14],
    },
    'test case 3' => {
        in  => [20, 24, 22, 48, 49, 23, 39, 10, 14, 43],
        out => [24, 49, 39, 43],
    },
);

for %test-cases.keys -> $test {
    is find-peak-elements-in(%test-cases{$test}.{<in>}),
       %test-cases{$test}.{<out>},
       $test;
}

done-testing;

#
#
# METHOD

sub find-peak-elements-in($array where { $_ > 0 }) {

    my @peak-elements = Empty;
    if $array.elems >= 2 {

        if ($array[0] > $array[1]) {
            @peak-elements.push: $array[0];
        }

        for 1 .. $array.elems-2 -> $i {
            if $array[$i] > $array[$i-1]
               &&
               $array[$i] > $array[$i+1] {

               @peak-elements.push: $array[$i];
            }
        }

        if $array[*-1] > $array[*-2] {
            @peak-elements.push: $array[*-1];
        }
    }

    return |@peak-elements;
}
