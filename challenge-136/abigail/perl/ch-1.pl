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
# for instance in week 82. So, we copy-and-pasted the code from that week.
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
    return $u if $u == $v || !$v;
    return $v if             !$u;
    my $u_odd = $u % 2;
    my $v_odd = $v % 2;
    return gcd ($u >> 1, $v >> 1) << 1 if !$u_odd && !$v_odd;
    return gcd ($u >> 1, $v)           if !$u_odd &&  $v_odd;
    return gcd ($u,      $v >> 1)      if  $u_odd && !$v_odd;
    return gcd ($u - $v, $v)           if  $u     >   $v;
    return gcd ($v - $u, $u);
}

#
# Main program
#
say $power_of_2 {gcd split} || 0 while <>;
