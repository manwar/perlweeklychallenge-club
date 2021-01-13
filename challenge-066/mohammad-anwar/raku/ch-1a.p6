#!/usr/bin/env raku

#
# Perl Weekly Challenge - 066
#
# Task #1: Divide Integers
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-066/
#

use Test;

is natural-div( 5,  2),  2, ' 5 /  2 =  2';
is natural-div(-5,  2), -3, '-5 /  2 = -3';
is natural-div(-5, -2),  2, '-5 / -2 =  2';

done-testing;

sub natural-div(Int $m, Int $n where $n != 0) {

    my $sign = '';
    if $m < 0 {
        $sign = '-' if $n > 0;
    }
    else {
        $sign = '-' if $n < 0;
    }

    my $abs_m = abs($m);
    my $abs_n = abs($n);

    my $i = 0;
    for 0 .. $abs_n {
        last if $abs_m <= $abs_n;
        $abs_m -= $abs_n;
        $i++;
    }

    $i++ if $sign ne '';

    return sprintf("%s%d", $sign, $i);
}
