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
# Now we want to calculate the list of factors of $gcd. 
#
# We do this by finding prime factors $p of $gcd. For each such
# $p, we find how often ($t) it divides $gcd. That is,
# $p ^ $t divides $gcd, but $p ^ ($t + 1) does not.
#
# We also keep a running list of factors (@f), containing all factors
# of the form q_1^a * .. * q_i^b, with q_1 < ... < q_i < p. This list
# is initialized to 1.
#
# For each new pair ($p, $t) found, and each $f in @f, we add
# $f * $p ^ $i, 1 <= $i <= $t to @f. We can then also divide
# $gcd by $p ^ $t.
#
# Note that in the loop below, we try *all* numbers starting from 2,
# not just primes. But any composite number will have a prime factor
# smaller than itself, and this will already be divided out of $gcd,
# so for any composite number $n, $n will never divide $gcd evenly.
#
# Also note that we stop if the current number is larger than the
# square of $gcd. This means that, at the end of the loop, $gcd may
# be a prime $r. In that case, for each found factor $f so far, we
# must add $r * $f to the list of factors.
# 
#
# The run time complexity is O (sqrt (p) + |f| log |f|), where
# p is largest prime factor, and |f| is the number of factors found.
#

my @factors = (1);
my $p = 2;
while ($p ** 2 <= $gcd) {
    #
    # Find out how often $p is a factor of $gcd
    #
    my $t = 0;
    until ($gcd % $p) {
        #
        # If we are here, $p cannot be composite.
        #
        $t ++;
        $gcd /= $p;
    }

    #
    # Push all new factors. For each 1 <= $i <= $t, and each $f already
    # in the list of factors, add $f * $p ^ $i to the list of factors.
    #
    # The test for $t isn't needed for correctness, just for performance.
    #
    if ($t) {
        push @factors => map {my $f = $_; map {$f * $p ** $_} 1 .. $t} @factors;
    }

    $p ++;
}

#
# Case where $gcd is left to be a prime.
#
push @factors => map {$_ * $gcd} @factors if $gcd > 1;

#
# Print the list of factors, after sorting.
#
say for sort {$a <=> $b} @factors;


__END__
