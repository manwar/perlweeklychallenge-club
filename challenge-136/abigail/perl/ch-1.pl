#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-1.pl < input-file
#

#
# We need the GCD of two numbers. We did this in the past a few times,
# for instance in weeks 82, 89 and 93.
# So, we copy-and-pasted some code.
#

#
# Find the GCD, using Stein's algorithm
#    (https://en.wikipedia.org/wiki/Binary_GCD_algorithm)
#
sub gcd;
sub gcd ($u, $v) {
    my ($u_odd, $v_odd) = ($u % 2, $v % 2);
       $u == $v || !$v     ? $u   
    :              !$u     ? $v
    : !$u_odd   && !$v_odd ? gcd ($u >> 1, $v >> 1) << 1
    : !$u_odd   &&  $v_odd ? gcd ($u >> 1, $v)
    :  $u_odd   && !$v_odd ? gcd ($u,      $v >> 1)
    :  $u       >   $v     ? gcd ($u - $v, $v)
    :                        gcd ($v - $u, $u)
}

#
# Return true of $number is a power of $n, that is
# $number == $n ^ $p for some non-negative integer $p
#
sub is_power_of_n ($number, $n) {
    use integer;
    $number <  1 ? 0
  : $number == 1 ? 1
  : $number % $n ? 0
  : is_power_of_n ($number / $n, $n)
}

sub is_power_of_2 ($number) {
    is_power_of_n ($number, 2)
}

#
# Main program
#
while (<>) {
    my ($n, $m) = split;
    say (0), next if ($n % 2) || ($m % 2);
    my  $r = gcd $n, $m;
    say $r > 1 && is_power_of_2 ($r) ? 1 : 0
}
