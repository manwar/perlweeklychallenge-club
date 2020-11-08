#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

use Math::BigInt;

#
# Challenge
#
# You are given a positive integer $N.
#
# Write a script to find if it can be expressed as a ^ b where a >
# 0 and b > 1. Print 1 if you succeed otherwise 0.
#

#
# We solve this *not* by factoring $N, but by searching for an nth root
# which gives an integer.
#
# Note that if $N is of the form a ^ b (a > 0, b > 1, a, b integer), then
# there is a solution of the form q ^ p, with q, p integer and p prime.
# (Proof: Let p be a prime factor of b, so b == p * c, for some c >= 1.
#  Then a ^ b == a ^ (c * p) == (a ^ c) ^ p. Then let q = a ^ c).
#
# So, we want to find a prime p, such that the p-th root of $N is an integer.
# Now, if $N > 1, and if $N == q ^ p, then q >= 2. Hence, p <= log_2 N.
# So, we want to test all primes less than log_2 N. (We will test some
# composite numbers as well, but we won't skip any primes).
#
# How do we test whether the p-th root is an integer? We will be making use
# of Math::BigInt. broot (p) gives the p-th root, but rounded to an integer.
# If we can do a round trip, that is raising the rounded p-th root to the p-th
# power, and be back in $N again, we have a winner.
#

#
# A little class we use to iterate over all primes, and some composite.
#
# Let p_i be the ordered set of all primes, p_i < p_j, iff i < j.
#
# Let P be the product of first n primes (p_1 * ... * p_n).
#
# Let S be the set of primes p_j, j > n, p_j <= P + 1.
#
# Then all primes p_j, j > n, are of the form:
#
#    k * P + l, k >= 0, l in S                        [1]
#
# (But not all numbers of that form are prime)
#
# For details, see https://en.wikipedia.org/wiki/Wheel_factorization
#
#
# We will use the class Wheel below to iterate over the set
#
#    p_1, .., p_n, k * P + 1, k >= 0, l in S
#
# This will iterate over all primes, and some composites.
#
# In particular, we pick n == 3, so p_1 == 2, p_2 == 3, and p_3 == 5.
#

#
# (Of course, this is a little overkill. 2^1000 is a number of over 300
#  digits, and it's unlikely the test inputs for this challenge will have
#  numbers going that large. We could easily list the 168 prime numbers
#  up to 1000 instead. But there is no fun in that! And just to prove a
#  a point, our test case includes 2^2311, a 696 digit number; 2311 is a
#  Euclid prime (2311 = 2 * 3 * 5 * 7 * 11 + 1)).
#

package Wheel {
    use List::Util 'product';
    use Hash::Util::FieldHash 'fieldhash';
    use overload '0+' => \&numify,
                 '++' => \&inc,
    ;

    my @primes  = (2, 3, 5);         # Base primes
    my $product = product @primes;   # Product of base primes

    #
    # Use a sieve to find all primes up to $product - 1.
    #
    my @sieve   = (1) x ($product + 2);
    $sieve [$_] = 0 for 0, 1;
    for (my $i = 2; $i <= sqrt $product; $i ++) {
        next unless $sieve [$i];
        for (my $j = $i * $i; $j <= $product; $j += $i) {
            $sieve [$j] = 0;
        }
    }
    #
    # Remove base primes
    #
    $sieve [$_] = 0 for @primes;

    my @batch   = grep {$sieve [$_]} keys @sieve; # Primes upto $product, other
                                                  # than the base primes, and
                                                  # $product + 1 (which may, or
                                                  # may not be prime). 
                                                  # These are the l's in [1].

    fieldhash my %index;                          # k in [1].
    fieldhash my %queue;                          # Next numbers to be returned.

    #
    # Initialize the object.
    #
    sub new  ($class) {bless \do {my $var} => $class}
    sub init ($self)  {
        $index {$self} = 0;
        $queue {$self} = [@primes];
        $self;
    }

    #
    # Overload methods
    #

    #
    # Increment the number. We're shifting of the first number of the
    # queue, and we replenish the queue if it's empty.
    #
    sub inc ($self, $, $) {
        shift @{$queue {$self}};
        if (!@{$queue {$self}}) {
            $queue {$self} = [map {$index {$self} * $product + $_} @batch];
            $index {$self} ++;
        }
        $self;
    }

    #
    # Current value: first element in the queue.
    #
    sub numify ($self, $, $) {
        $queue {$self} [0];
    }
}

NUMBER: while (<>) {
    #
    # Read the number
    #
    my $N = Math::BigInt:: -> new ($_);

    #
    # Special case $N == 1
    #
    if ($N == 1) {
        say 1;
        next;
    }

    #
    # Maximum value of the exponent.
    #
    my $max_exponent = $N -> copy -> blog (2);

    #
    # $exponent will the number(s) we try as exponent.
    #
    my $exponent = Wheel:: -> new -> init;

    while ($exponent <= $max_exponent) {
        if ($N == $N -> copy -> broot ($exponent) -> bpow ($exponent)) {
            say 1;
            next NUMBER;
        }
            
        $exponent ++;
    }
    say 0;
}

   

__END__
