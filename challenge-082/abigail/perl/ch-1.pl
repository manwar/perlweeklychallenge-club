#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# Challenge
#
#   You are given 2 positive numbers $M and $N.
#
#   Write a script to list all common factors of the given numbers.
#

#
# All common factors are the factors of the greatest common divider (gcd)
# Find the gcd is easy, Euclid already had an algorithm.
#

#
# However, finding all factors of a given number is a HARD PROBLEM.
# Easy to brute force for small numbers, but we'd need a sieve to
# do this for some what larger numbers. For most numbers, even a sieve
# will be unwieldy.
#
# Let's hope we only get smallish numbers...
#

#
# Get the two numbers
#
chomp (my $M = <>);
chomp (my $N = <>);


#
# Find the GCD, using Stein's algorithm
#    (https://en.wikipedia.org/wiki/Binary_GCD_algorithm)
#
sub stein;
sub stein ($u, $v) {
    return $u if $u == $v || !$v;
    return $v if             !$u;
    my $u_odd = $u % 2;
    my $v_odd = $v % 2;
    return stein ($u >> 1, $v >> 1) << 1 if !$u_odd && !$v_odd;
    return stein ($u >> 1, $v)           if !$u_odd &&  $v_odd;
    return stein ($u,      $v >> 1)      if  $u_odd && !$v_odd;
    return stein ($u - $v, $v)           if  $u     >   $v;
    return stein ($v - $u, $u);
}


my $gcd = stein $M, $N;

#
# Brute force finding all factors
#
my $max = int sqrt $gcd;
my @small;   # All factors <= sqrt ($gcd);
my @large;   # All factors >  sqrt ($gcd);
for (my $i = 1; $i <= $max; $i ++) {
    next if $gcd % $i;
    push @small => $i;
    # If $gcd is a perfect square, we should not report
    # its square root twice.
    push @large => $gcd / $i unless $gcd / $i == $i;
}
say for @small, reverse @large;

__END__
