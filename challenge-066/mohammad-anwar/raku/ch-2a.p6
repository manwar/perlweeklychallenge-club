#!/usr/bin/env perl6

#
# Perl Weekly Challenge - 066
#
# Task #2: Power Integers
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-066/
#

use Test;

is sprintf("%d = %s", 9, get-power-integers(9).join(", ")),
   '9 = 3 ^ 2',
   '9 = 3 ^ 2';
is sprintf("%d = %s", 45, get-power-integers(45).join(", ")),
   '45 = 0',
   '45 = 0';
is sprintf("%d = %s", 64, get-power-integers(64).join(", ")),
   '64 = 2 ^ 6, 4 ^ 3, 8 ^ 2',
   '64 = 2 ^ 6, 4 ^ 3, 8 ^ 2';

done-testing;

sub get-power-integers(Int $n where { $n > 1 }) {

    my $power_integers = [];

    my $i = 2;
    while $i <= sqrt($n) {
        my $j = 2;
        while $j <= $n {
            if ($i ** $j) == $n {
                $power_integers.push: sprintf("%d ^ %d", $i, $j);
            }
            $j++;
        }
        $i++;
    }

    return $power_integers if $power_integers.elems > 0;
    return 0;
}
