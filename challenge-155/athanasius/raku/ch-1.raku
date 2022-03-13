use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 155
=========================

TASK #1
-------
*Fortunate Numbers*

Submitted by: Mohammad S Anwar

Write a script to produce first 8 Fortunate Numbers (unique and sorted).

According to [ https://en.wikipedia.org/wiki/Fortunate_number |Wikipedia]

    A Fortunate number, named after Reo Fortune, is the smallest integer m > 1
    such that, for a given positive integer n, pn# + m is a prime number, where
    the primorial pn# is the product of the first n prime numbers.

Expected Output

 3, 5, 7, 13, 17, 19, 23, 37

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
Although the Task specifies n = 8, I have extended the solution to accept any
target integer value of n greater than 1. (If no argument is supplied on the
command line, the target n defaults to 8.)

Algorithm
---------
Generating Fortunate numbers is straightforward: given successive primes, gen-
erate successive primorials, and for each new primorial pn# search for the
smallest m > 1 which satisfies the condition: (pn# + m) is prime. Discard
duplicates as they are found.

However, because solutions are generated out-of-order, the problem is to know
how many Fortunate numbers to produce to be sure that none are missing from the
solution. For example, when n = 9, the solution is:

    3, 5, 7, 13, 17, 19, 23, 37, 47

but the first 12 Fortunate numbers generated are

    3, 5, 7, 13, 23, 17, 19, 37, 61, 67, 71, 47

showing that the 9th element in the solution is found only *after* the larger
Fortunate numbers 61, 67, and 71 have been generated.

The answer to this problem arises from the following observation: a primorial
pn# = 2 x 3 x 5 x ... x pn, from which it follows that:

  - pn# + 2 is divisible by 2, and so not prime;
  - pn# + 3 is divisible by 3, and so not prime;
  - and so on up to pn;
  - moreover, pn# + c, where c is a composite number with all prime factors in
    the set { 2, 3, ... pn }, will also be divisible by c's prime factors and
    so not prime.

Also, p#n + 1 may be prime, but is excluded because it is required that m > 1.
Hence, the smallest possible value of m is pn + 1.

Let m_max be the nth entry in the sorted list of unique Fortunate numbers found
so far. As the search proceeds, the value of pn increases. When pn becomes as
large as m_max, it is impossible for the next value of m to be less than m_max,
so the search can safely end.

Note
----
My attempts to install the Math::Primesieve module were unsuccessful. In the
end, I wrote sub next-prime() which finds the next prime number using Raku's
built-in is-prime() method. This is inefficient, but the inefficiency is not
significant in this context because the primes generated remain small.

References
----------
[1] "A046066  Fortunate primes (A005235) in numerical order with duplicates
     removed", The On-Line Encyclopedia of Integer Sequences,
     https://oeis.org/A046066
[2] "A082115  Fibonacci sequence (mod 3).", The On-Line Encyclopedia of Integer
     Sequences, https://oeis.org/A082115
[3] "Primorial", Wikipedia, https://en.wikipedia.org/wiki/Primorial

=end comment
#==============================================================================

my UInt constant $TARGET = 8;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 155, Task #1: Fortunate Numbers (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    #| Integer > 1: Required number of output values

    UInt:D $target where { $target > 1 } = $TARGET
)
#==============================================================================
{
    my UInt $prime      = 2;
    my UInt $primorial  = $prime;
    my UInt @fortunates = 3;
    my UInt $count      = 0;

    until $count >= $target && $prime >= @fortunates[ $target - 1 ]
    {
        $prime      = next-prime( $prime );
        $primorial *= $prime;

        my UInt $m  = $prime + 2;
                $m += 2 until is-prime( $primorial + $m );

        if $m == @fortunates.none           # Discard duplicates
        {
            ++$count;
            @fortunates.push: $m;
            @fortunates.=sort;              # Keep sorted
        }
    }

    "The first $target Fortunate Numbers (unique and sorted):\n%s\n".printf:
        @fortunates[ 0 .. $target - 1 ].join: ', ';
}

#------------------------------------------------------------------------------
sub next-prime( UInt:D $last-prime where { $last-prime.is-prime } --> UInt:D )
#------------------------------------------------------------------------------
{
    my UInt $next-prime = 3;

    if $last-prime > 2
    {
        $next-prime  = $last-prime + 2;
        $next-prime += 2 until $next-prime.is-prime;
    }

    return $next-prime;
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
