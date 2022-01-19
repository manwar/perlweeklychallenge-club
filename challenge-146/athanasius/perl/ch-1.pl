#!perl

###############################################################################
=comment

Perl Weekly Challenge 146
=========================

TASK #1
-------
*10001st Prime Number*

Submitted by: Mohammad S Anwar

Write a script to generate the 10001st prime number.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm
---------
Primes are identified using a standard Sieve of Eratosthenes [1]. The only
difficulty is determining the minimal size of the sieve needed to guarantee a
sufficient number of primes. For this purpose, the prime-counting function
pi(n) is used to estimate the number of primes less than or equal to n. From
[2], the lower bound for pi(n) is given by:

    n/ln(n) < pi(n)

A value of n = 116,700 gives n/ln(n) = 10,002.261, which is just slightly
greater than the target of 10,001.

Solution
--------
This script identifies the 10,001st prime number as 104,743. This is confirmed
by [3], which contains the following entries:

    ...
    10000 104729
    10001 104743
    10002 104759
    ...

References
----------
[1] Wikipedia, "Sieve of Eratosthenes".
    https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
[2] Weisstein, Eric W. "Prime Counting Function." From MathWorld--A Wolfram Web
    Resource. https://mathworld.wolfram.com/PrimeCountingFunction.html
[3] N. J. A. Sloane, "Table of n, prime(n) for n = 1..100000".
    https://oeis.org/A000040/a000040.txt

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;

const my $TARGET   =>  10_001;
const my $SIEVE_SZ => 116_700;                           # See discussion above
const my $USAGE    => "Usage:\n  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 146, Task #1: 10001st Prime Number (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0
        or die "ERROR: Expected 0 command line arguments, found $args\n$USAGE";

    my $count =  0;
    my @sieve = (0) x $SIEVE_SZ;
    my $latest_prime;

    for my $i (2 .. $#sieve)
    {
        if ($sieve[ $i ] == 0)
        {
            $latest_prime = $i;

            last if ++$count >= $TARGET;

            for (my $j = $i * $i; $j <= $#sieve; $j += $i)
            {
                $sieve[ $j ] = 1;
            }
        }
    }

    $count == $TARGET
        or die "ERROR: Found $count primes, target is $TARGET\n";

    printf "The %sst prime number is %s\n",
            commify( $count ), commify( $latest_prime );
}

#------------------------------------------------------------------------------
# Adapted from: https://perldoc.perl.org/perlfaq5#
#               How-can-I-output-my-numbers-with-commas-added%3F
#
sub commify
#------------------------------------------------------------------------------
{
    my ($n) = @_;

    1 while $n =~ s/ ^ ([-+]? \d+) (\d{3}) /$1,$2/x;

    return $n;
}

###############################################################################
