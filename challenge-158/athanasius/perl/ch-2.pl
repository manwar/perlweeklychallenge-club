#!perl

###############################################################################
=comment

Perl Weekly Challenge 158
=========================

TASK #2
-------
*First Series Cuban Primes*

Submitted by: Mohammad S Anwar

Write a script to compute first series Cuban Primes <= 1000. Please refer
[ https://en.wikipedia.org/wiki/Cuban_prime |wikipedia page] for more informa-
tions.

Output

 7, 19, 37, 61, 127, 271, 331, 397, 547, 631, 919.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm
---------
The first-series Cuban Primes are a subset of the centred hexagonal (or "hex")
numbers [1, 3]. So, the algorithm begins by generating consecutive hex numbers,
using the formula:

    H(n) = 3n² - 3n + 1

where H(n) is the nth centered hexagonal number [2].

As each hex number is generated, it is tested for primality using the Sieve of
Eratosthenes (which is created on first call for integers in the target range).
Hex numbers found to be prime are stored.

When all hex numbers in the target range have been evaluated, the stored prime
hex numbers are output as the required first-series Cuban Primes.

References
----------
[1] "A002407  Cuban primes: primes which are the difference of two consecutive
     cubes.", OEIS, https://oeis.org/A002407
[2] "Centered hexagonal number", Wikipedia,
     https://en.wikipedia.org/wiki/Centered_hexagonal_number
[3] "Cuban prime", Wikipedia, https://en.wikipedia.org/wiki/Cuban_prime

=cut
#==============================================================================

use strict;
use warnings;
use feature qw( state );
use Const::Fast;

const my $MAX   => 1_000;
const my $USAGE => "Usage:\n  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 158, Task #2: First Series Cuban Primes (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0 or die 'ERROR: Expected 0 command line arguments, found ' .
                         "$args\n$USAGE";

    my @cuban_primes;

    for (my ($n, $hex_number) = (1, 0); $hex_number <= $MAX; ++$n)
    {
        my $triple  = 3 * $n;
        $hex_number = $triple * $n - $triple + 1;

        push @cuban_primes, $hex_number if is_prime( $hex_number );
    }

    splice @cuban_primes, -1, 1 if $cuban_primes[ -1 ] > $MAX;

    printf "The %d first-series Cuban Primes <= %d:\n\n %s\n",
            scalar @cuban_primes, $MAX, join ', ', @cuban_primes;
}

#------------------------------------------------------------------------------
sub is_prime
#------------------------------------------------------------------------------
{
    # On first call, create a Sieve of Eratosthenes in the range 0 .. $MAX

    state @is_prime = (0, 0, (1) x ($MAX - 1));             # 0, 1, (2 .. $MAX)

    if (state $first_call = 1)
    {
        $first_call = 0;

        for my $n (0 .. $MAX)
        {
            next unless $is_prime[ $n ];                    # Skip non-primes

            for (my $i = 2 * $n; $i <= $MAX; $i += $n)
            {
                $is_prime[ $i ] = 0;
            }
        }
    }

    my ($n) = @_;

    return $is_prime[ $n ];                                 # Sieve look-up
}

###############################################################################
