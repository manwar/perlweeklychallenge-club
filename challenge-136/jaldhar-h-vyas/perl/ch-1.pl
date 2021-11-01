#!/usr/bin/perl
use 5.020;
use warnings;

sub log2 {
    my ($n) = @_;

    return log($n) / log(2);
}

sub gcd {
    my ($a, $b) = @_;

    return 0 == $b ? $a : gcd($b, $a % $b);
}

my ($m, $n) = @ARGV;

my $x = log2(gcd($m, $n));
say  $x == int($x) ? 1 : 0;
