#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

use bigint;

#
# Challenge
#
# You are given a positive integer $N.
#
# Write a script to find if it can be expressed as a ^ b where a >
# 0 and b > 1. Print 1 if you succeed otherwise 0.
#

#
# We can solve this by looking at the prime factors of $N, and see
# whether their exponents have a gcd > 1.
#
# We will use a similar algorithm as we used in week 82, part 1:
# 
# - For each prime factor p, we find how often it divides $N, say k_p times.
# - Calculate the gcd of all k_i for which k_i > 0.
# - $N can be expressed as a ^ b, a > 0, b > 1, iff the gcd > 1.
#
# To calculate the gcd, we just keep a running gcd g: for each prime factor p
# we find, g = gcd (g, k_p). We can stop if g becomes 1.
#

#
# Copied from week 82
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

NUMBER: while (<>) {
    #
    # Read the number
    #
    chomp;
    my $N   = $_;
    my $gcd = 0; # Running gcd

    #
    # Find the prime factors. We only have to consider 2, 3, and integers
    # of the form 6 * k -/+ 1, for k > 0. For each prime factor $p found,
    # we can divide $N by $p. We can stop if $p ** 2 exceeds $N.
    #
    my $p = 2;
    while ($p ** 2 <= $N || $p == $N) {
        my $k = 0;
        while ($N % $p == 0) {
            #
            # $p divides $N. If we are here, $p cannot be composite.
            #
            $N /= $p;
            $k ++;
        }

        #
        # Note that if either argument of stein() is 0, the result
        # is the other argument (and the sub won't recurse). So, if
        # $p doesn't divide $N, $k is 0, and $gcd is left unmodified.
        # Furtermore, since we start off with $gcd equal to 0, $gcd
        # will be set to a non-zero value when we hit the lowest 
        # prime factor of $N.
        #

        if (($gcd = stein ($k, $gcd)) == 1) {
            #
            # No solution
            #
            say 0;
            next NUMBER;
        }
        $p += $p     == 2 ? 1
            : $p     == 3 ? 2
            : $p % 6 == 1 ? 4
            :               2;
    }
    say $N == 1 ? 1    # Success!
                : 0    # Failure: $N is a prime we haven't been able to divide
                       #          out, so there is a prime p which divides the
                       #          input number, but p^2 does not.
}

   

__END__
