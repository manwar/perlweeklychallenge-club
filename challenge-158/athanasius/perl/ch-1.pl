#!perl

###############################################################################
=comment

Perl Weekly Challenge 158
=========================

TASK #1
-------
*Additive Primes*

Submitted by: Mohammad S Anwar

Write a script to find out all Additive Primes <= 100.

    Additive primes are prime numbers for which the sum of their decimal digits
    are also primes.

Output

 2, 3, 5, 7, 11, 23, 29, 41, 43, 47, 61, 67, 83, 89

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm
---------
1. Generate primes in the required range using the Sieve of Eratosthenes [3]
2. For each prime in the sieve:
    - sum the digits
    - if the sum is a prime number recorded in the sieve, add it to the list of
      additive primes
3. Output the list of additive primes

References
----------
[1] "A046704  Additive primes: sum of digits is a prime.", OEIS,
     https://oeis.org/A046704
[2]  Reinhard Zumkeller, "Table of n, a(n) for n = 1..10000", OEIS,
     https://oeis.org/A046704/b046704.txt
[3] "Sieve of Eratosthenes", Wikipedia,
     https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;

const my $MAX   => 100;
const my $USAGE => "Usage:\n  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 158, Task #1: Additive Primes (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0 or die 'ERROR: Expected 0 command line arguments, found ' .
                         "$args\n$USAGE";

    my @is_prime = (0, 0, (1) x ($MAX - 1));         # Sieve: 0, 1, (2 .. $MAX)

    for my $n (0 .. $MAX)                                     # Find the primes
    {
        next unless $is_prime[ $n ];                          # Skip non-primes

        for (my $i = 2 * $n; $i <= $MAX; $i += $n)
        {
            $is_prime[ $i ] = 0;
        }
    }

    my @additive_primes;

    for my $p (0 .. $MAX)
    {
        next unless $is_prime[ $p ];                          # Skip non-primes

        my $sum  = 0;
           $sum += $_ for split '', $p;

        push @additive_primes, $p if $is_prime[ $sum ];
    }

    printf "Additive primes <= %d:\n\n %s\n",
            $MAX, join ', ', @additive_primes;
}

###############################################################################
