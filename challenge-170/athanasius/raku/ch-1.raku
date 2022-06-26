use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Algorithm
---------
Primes are found using Raku's in-built is-prime method.

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

=end comment
#==============================================================================

my UInt constant $TARGET = 10;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 170, Task #1: Primorial Numbers (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    my UInt @primorials = 1;

    loop (my $n = 2; +@primorials < $TARGET; ++$n)
    {
        @primorials.push: @primorials[ *-1 ] * $n if $n.is-prime;
    }

    "The first %d primorial numbers:\n%s\n".printf:
        $TARGET, @primorials.join: ', ';
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
