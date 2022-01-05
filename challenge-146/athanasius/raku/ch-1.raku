use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 146
=========================

TASK #1
-------
*10001st Prime Number*

Submitted by: Mohammad S Anwar

Write a script to generate the 10001st prime number.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

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

=end comment
#==============================================================================

my UInt constant $TARGET   =  10_001;
my UInt constant $SIEVE-SZ = 116_700;                    # See discussion above

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 146, Task #1: 10001st Prime Number (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    my $count = 0;
    my @sieve = 0 xx $SIEVE-SZ;
    my $latest-prime;

    for 2 .. @sieve.end -> UInt $i
    {
        if @sieve[ $i ] == 0
        {
            $latest-prime = $i;

            last if ++$count >= $TARGET;

            loop (my UInt $j = $i * $i; $j <= @sieve.end; $j += $i)
            {
                @sieve[ $j ] = 1;
            }
        }
    }

    $count == $TARGET
        or die "ERROR: Found $count primes, target is $TARGET\n";

    "The %sst prime number is %s\n".printf:
            commify( $count ), commify( $latest-prime );
}

#------------------------------------------------------------------------------
# Adapted from: https://perldoc.perl.org/perlfaq5#
#               How-can-I-output-my-numbers-with-commas-added%3F
#
sub commify( Int:D $n --> Str:D )
#------------------------------------------------------------------------------
{
    my Str $s = ~$n;

    Nil while $s ~~ s/ ^ (<[-+]>? \d+) (\d ** 3) /$0,$1/;

    return $s;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

##############################################################################
