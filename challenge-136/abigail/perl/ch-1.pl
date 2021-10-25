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
# We could write some code to check whether a number is a power of 2.
# But there are only 63 powers of 2 which fit in a 64 bit integer, one
# of them being 1. So, we can just precalculate the ones we're interested in.
#
my %power_of_2 = map {1 << $_ => 1} 1 .. 62;

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
# Main program
#
say $power_of_2 {gcd split} || 0 while <>;
