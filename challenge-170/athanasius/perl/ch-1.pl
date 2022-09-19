#!perl

###############################################################################
=comment

Perl Weekly Challenge 170
=========================

TASK #1
-------
*Primorial Numbers*

Submitted by: Mohammad S Anwar

Write a script to generate first 10 Primorial Numbers.


    Primorial numbers are those formed by multiplying successive prime numbers.


For example,

 P(0) = 1    (1)
 P(1) = 2    (1x2)
 P(2) = 6    (1x2×3)
 P(3) = 30   (1x2×3×5)
 P(4) = 210  (1x2×3×5×7)

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm
---------
Primes are found by the extensible sieve of Eratosthenes used in the solution
to Task 1 of Week 169.

Each new primorial is found by multiplying the previous primorial by the next
successive prime number.

Table
-----
Primorial numbers (from [1]):
     1, 2, 6, 30, 210, 2310, 30030, 510510, 9699690, 223092870, 6469693230,
     200560490130, 7420738134810, 304250263527210, 13082761331670030,
     614889782588491410, 32589158477190044730, 1922760350154212639070,
     117288381359406970983270, 7858321551080267055879090

References
----------
[1] "A002110  Primorial numbers (first definition): product of first n primes.
     Sometimes written prime(n)#.", OEIS, https://oeis.org/A002110
[2] "Primorial", Wikipedia, https://en.wikipedia.org/wiki/Primorial

=cut
#==============================================================================

use strict;
use warnings;
use feature qw( state );
use Const::Fast;

use constant TARGET => 10;

use if TARGET > 16, 'bigint';

const my $USAGE => "Usage:\n  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 170, Task #1: Primorial Numbers (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0
            or die "Expected 0 command line arguments, found $args\n$USAGE";

    my @primes;

    for (my $digits = 1; scalar @primes < TARGET - 1; ++$digits)
    {
        push @primes, @{ get_primes( $digits ) };
    }

    my @primorials = (1);

    for my $i (0 .. TARGET - 2)
    {
        push @primorials, $primorials[ -1 ] * $primes[ $i ];
    }

    printf "The first %d primorial numbers:\n%s\n",
            TARGET, join ', ', @primorials;
}

#------------------------------------------------------------------------------
sub get_primes                               # Extensible sieve of Eratosthenes
#------------------------------------------------------------------------------
{
    my   ($digits)  = @_;
    my    $max_idx  = 10 ** $digits - 1;
    state @sieve    = ((0, 0), (1) x ($max_idx - 1));
    my    $orig_end = $#sieve;
    state $first    = 1;

    if ($first || $max_idx > $orig_end)
    {
        push @sieve, (1) x ($max_idx - $orig_end) if !$first;    # Extend sieve

        for my $i (0 .. int sqrt $max_idx)
        {
            if ($sieve[ $i ])                                    # Prime
            {
                my $start = $first ? 2 : int( ($orig_end + 1) / $i );

                for my $j ($start .. int( $max_idx / $i ))
                {
                    $sieve[ $i * $j ] = 0;                       # Composite
                }
            }
        }

        $first = 0;
    }

    # @range contains all integers of the required number of digits:
    # e.g., if $digits = 2 then @range = 10 .. 99

    my @range = 10 ** ($digits - 1) .. $max_idx;

    return [ grep { $sieve[ $_ ] } @range ];                  # Apply the sieve
}

###############################################################################
