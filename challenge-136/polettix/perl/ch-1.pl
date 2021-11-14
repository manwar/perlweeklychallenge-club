#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say two_friendly(@ARGV ? @ARGV[0, 1] : (8, 24)) ? 1 : 0;
sub two_friendly ($m, $n) { positive_power2(gcd($m, $n)) }
sub positive_power2 ($x) { $x > 1 && is_power2($x) }
sub is_power2 ($x) { $x == 1 || $x > 0 && !($x % 2) && is_power2($x >> 1) }
sub gcd ($A, $B) { ($A, $B) = ($B % $A, $A) while $A; $B }
