#!/usr/bin/perl

#
# Perl Weekly Challenge - 066
#
# Task #2: Power Integers
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-066/
#

use strict;
use warnings;

use Test::More;
use Test::Deep;

is_deeply(get_power_integers(9),
          ['3 ^ 2'],
          ' 9 = 3 ^ 2');
is_deeply(get_power_integers(45),
          [ 0 ],
          '45 = N/A');
is_deeply(get_power_integers(64),
          ['2 ^ 6', '4 ^ 3', '8 ^ 2'],
          '64 = 2 ^ 6, 4 ^ 3, 8 ^ 2');

done_testing;

sub get_power_integers {
    my ($n) = @_;

    my $power_integers = [];

    my $i = 2;
    while ( $i <= sqrt($n) ) {
        my $j = 2;
        while ( $j <= $n ) {
            if (($i ** $j) == $n) {
                push @$power_integers, sprintf("%d ^ %d", $i, $j);
            }
            $j++;
        }
        $i++;
    }

    $power_integers = [0] unless scalar(@$power_integers);

    return $power_integers;
}
