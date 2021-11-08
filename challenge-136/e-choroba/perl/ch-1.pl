#! /usr/bin/perl
use warnings;
use strict;

sub gcd {
    my ($m, $n) = @_;
    while ($m && $n) {
        ($m, $n) = ($n, $m) if $n < $m;
        $n -= int($n / $m) * $m;
    }
    return $m
}

sub two_friendly {
    my ($m, $n) = @_;
    my $g = gcd($m, $n);
    my $binary = sprintf '%b', $g;
    return 1 == $binary =~ tr/1// ? 1 : 0
}

use Test2::V0;
plan 3;

is two_friendly(8, 24), 1, 'Example 1';
is two_friendly(26, 39), 0, 'Example 2';
is two_friendly(4, 10), 1, 'Example 3';
