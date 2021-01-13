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

my $M = $ARGV[0];
my $N = $ARGV[1];

print sprintf("%d / %d = %s\n", $M, $N, natural_div($M, $N));

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
