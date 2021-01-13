#!/usr/bin/perl
# The Weekly Challenge - Perl & Raku - 089
# Task 1: GCD Sum
# Usage: ch-1.pl $N

use strict;
use warnings;
use Test::More tests => 3;

sub gcd {
    my ($a,$b) = ($_[0], $_[1]);
    ($a, $b) = ($b, $a) if $a < $b;
    return !($a % $b) ? $b :  gcd($b , $a % $b);
}

my $x;

if ($ARGV[0]) {
    $x = $ARGV[0];
} else
{
    $x = 10;
    print "10\n";
}

sub pair_gcd {
    my $n = $_[0];
    my $ans = 0;
    for my $i (1..$n-1) {
        for my $j ($i+1..$n) {
            $ans += gcd($i,$j);
        }
    }
    return $ans;
}

print pair_gcd($x);

print "\n";

ok ( pair_gcd(3) == 3, "example 1");
ok( pair_gcd(4) == 7 , "example 2");
ok( pair_gcd(6) == 20 , "test case for six");
