#!/usr/bin/perl

#
# Perl Weekly Challenge - 066
#
# Task #1: Divide Integers
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-066/
#

use strict;
use warnings;

use POSIX;
use Test::More;

is (natural_div( 5,  2), floor( 5 /  2), ' 5 /  2 =  2');
is (natural_div(-5,  2), floor(-5 /  2), '-5 /  2 = -3');
is (natural_div(-5, -2), floor(-5 / -2), '-5 / -2 =  2');

done_testing;

sub natural_div {
    my ($m, $n) = @_;

    die "ERROR: Missing dividend.\n" unless defined $m;
    die "ERROR: Missing divisor.\n"  unless defined $n;
    die "ERROR: Dividend > Divisor [$m / $n].\n"     unless abs($m) > abs($n);
    die "ERROR: Invalid divisor [$n], can't be 0.\n" if $n == 0;

    my $sign = '';
    if ($m < 0) {
        $sign = '-' if ($n > 0);
    }
    else {
        $sign = '-' if ($n < 0);
    }

    my $abs_m = abs($m);
    my $abs_n = abs($n);

    my $i = 0;
    for ($i = 0; $abs_m >= $abs_n; $i++) {
        $abs_m -= $abs_n;
    }

    $i++ if ($sign ne '');

    return sprintf("%s%d", $sign, $i);
}
