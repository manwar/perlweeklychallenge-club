use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Algorithm
---------
The first-series Cuban Primes are a subset of the centred hexagonal (or "hex")
numbers [1, 3]. So, the algorithm begins by generating consecutive hex numbers,
using the formula:

    H(n) = 3n² - 3n + 1

where H(n) is the nth centered hexagonal number [2].

As each hex number is generated, it is tested for primality using Raku's built-
in is-prime() method. Hex numbers found to be prime are stored.

When all hex numbers in the target range have been evaluated, the stored prime
hex numbers are output as the required first-series Cuban Primes.

References
----------
[1] "A002407  Cuban primes: primes which are the difference of two consecutive
     cubes.", OEIS, https://oeis.org/A002407
[2] "Centered hexagonal number", Wikipedia,
     https://en.wikipedia.org/wiki/Centered_hexagonal_number
[3] "Cuban prime", Wikipedia, https://en.wikipedia.org/wiki/Cuban_prime

=end comment
#==============================================================================

my UInt constant $MAX = 1_000;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 158, Task #2: First Series Cuban Primes (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    my UInt @cuban-primes;

    loop (my UInt ($n, $hex-number) = 1, 0; $hex-number <= $MAX; ++$n)
    {
        my UInt $triple = 3 * $n;
        $hex-number     = $triple * $n - $triple + 1;

        @cuban-primes.push: $hex-number if $hex-number.is-prime;
    }

    @cuban-primes.splice: *-1, 1 if @cuban-primes[ *-1 ] > $MAX;

    "The %d first-series Cuban Primes <= %d:\n\n %s\n".printf:
        +@cuban-primes, $MAX, @cuban-primes.join: ', ';
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
