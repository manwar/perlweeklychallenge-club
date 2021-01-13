use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 076
=========================

Task #1
-------
*Prime Sum*

Submitted by: Mohammad S Anwar
Reviewed by:  Ryan Thompson

You are given a number $N. Write a script to find the minimum number of prime
numbers required, whose summation gives you $N.

For the sake of this task, please assume 1 is not a prime number.

Example:

 Input:
     $N = 9

 Output:
     2 as sum of 2 prime numbers i.e. 2 and 7 is same as the input number.
     2 + 7 = 9.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
  (1) A single number is a "sum" of one term: "Summation of a sequence of only
      one element results in this element itself." [4]
  (2) Let the minimum number of prime numbers required to sum to N be denoted by
      P(N).
  (3) The primes in the summation need not be distinct; e.g., P(4) = 2 because
      2 + 2 = 4.
  (4) Although Task 1 asks only for P(N), a more interesting challenge is to
      find an example set S such that:
        S = { s, t, ... | s, t, ... are prime ∧ ∑(s, t, ...) = N ∧ |S| = P(N) }
      The solution given below outputs both P(N) and an example set S.

Observations
------------
  (1) Adding an odd integer to another odd integer always produces an even sum.
  (2) Likewise, subtracting an odd integer from another odd integer always
      produces an even difference.
  (3) If N is prime, P(N) = 1 by Assumption (1).
  (4) If N is composite and even, P(N) = 2.
      -- This is the strong Goldbach conjecture, unproven but shown to hold for
         all integers < 4 × 10¹⁸ [2],[3].
         Note: "The expression of a given even number as a sum of two primes is
                called a Goldbach partition of that number." [3]
  (5) If N is composite and odd, then:
(5.1) P(N) = 2 iff (N - 2) is prime; e.g., 2 + 47 = 49.
      -- This is the only case in which P(N) = 2 for odd N, because 2 is the
         only even prime number, and if two odd primes are added together the
         sum must be even, by Observation (1).
(5.2) P(N) = 3 otherwise.
      -- This latter result follows from the weak, or ternary, Goldbach
         conjecture that "every odd integer n greater than 5 is the sum of three
         primes", which was proven by H. A. Helfgott in 2013 [1]. Examples:
         (i) 2 + 2 + 31 = 35   (ii) 3 + 3 + 113 = 119   (iii) 3 + 5 + 113 = 121
  (6) Let p + q + r = N where p, q, r are primes and N is odd. Then N - p =
      q + r, and since (N - p) is even, by Observation (2), this reduces to the
      strong Goldbach conjecture of Observation (4).

Strategies for finding a solution set S
---------------------------------------
  (1) To find a Goldbach partition for even composite integer N:
      for each prime p, beginning with the smallest, test whether (N - p) is
      prime; if it is, the partition has been found.
      -- This is the approach taken in [2]: "Our strategy will be to find the
         minimal Goldbach partition ... i.e., the one that uses the smallest
         possible prime number".
  (2) If N is composite and odd, begin by finding p, the largest prime < N, then
      find a Goldbach partition corresponding to P(N - p) per Observation (4).
      -- Choosing the largest possible value for p minimizes (N - p) and so
         (most likely) makes the search for the Goldbach partition as fast as
         possible.

Results
-------
According to the "Verified_results" section of [3], "3325581707333960528 is the
smallest number that has no Goldbach partition with a prime below 9781." With
timing code added, the script below finds the Goldbach partition for
3,325,581,707,333,960,528 (viz., 9,781 + 3,325,581,707,333,950,747) in around
0.2 seconds!

References
----------
[1] H. A. Helfgott (2013), "The ternary Goldbach conjecture is true",
    https://arxiv.org/abs/1312.7748
[2] Tomás Oliveira e Silva (2015), "Goldbach conjecture verification",
    http://sweet.ua.pt/tos/goldbach.html
[3] Wikipedia, "Goldbach's conjecture",
    https://en.wikipedia.org/wiki/Goldbach%27s_conjecture
[4] Wikipedia, "Summation", https://en.wikipedia.org/wiki/Summation

=end comment
#===============================================================================

use Math::Prime::Util:from<Perl5> <prev_prime prime_iterator>;

my Bool constant TIMER = False;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 076, Task #1: Prime Sum (Raku)\n".put;
}

##==============================================================================
sub MAIN
(
    UInt:D $N where $N > 1                      #= Summation target: integer > 1
)
##==============================================================================
{
    my $t0 = DateTime.now if TIMER;

    my UInt @primes;

    if $N.is-prime                                          # Observation (3)
    {
        @primes = $N;
    }
    elsif $N % 2 == 0                                       # Observation (4)
    {
        @primes = find-Goldbach-partition($N);
    }
    elsif ($N - 2).is-prime                                 # Observation (5.1)
    {
        @primes = 2, $N - 2;
    }
    else                                                    # Apply Strategy (2)
    {
        my UInt $prev = prev_prime($N);
        @primes = find-Goldbach-partition($N - $prev);
        @primes.push: $prev;
    }

    my $t1 = DateTime.now if TIMER;

    my Str $N-str = add-commas($N);

    "The minimum number of prime numbers required to sum to %s is %d:\n".printf:
        $N-str, @primes.elems;

    "%s = %s\n".printf: @primes.map( { add-commas($_) } ).join(' + '), $N-str;

    "\nTime taken: %.2fs\n".printf: $t1 - $t0 if TIMER;
}

#-------------------------------------------------------------------------------
sub find-Goldbach-partition                                       # Strategy (1)
(
    UInt:D $N where $N > 1
--> Array:D[UInt:D]
)
#-------------------------------------------------------------------------------
{
    $N % 2 == 0 or die "ERROR: \$N($N) must be even";

    my UInt @primes;

    if $N == 4
    {
        @primes = 2, 2;
    }
    else
    {
        my Callable $it  = prime_iterator(3);
        my UInt     $max = floor($N / 2);

        loop (my UInt $prime = $it.(); $prime <= $max; $prime = $it.())
        {
            if (my UInt $diff = $N - $prime).is-prime
            {
                @primes = $prime, $diff;
                last;
            }
        }
    }

    my UInt $count = @primes.elems;

    $count == 2 or die "ERROR: Expected 2 primes but found $count";

    return @primes;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

#-------------------------------------------------------------------------------
sub add-commas( UInt:D $number --> Str:D )
#-------------------------------------------------------------------------------
{
    # From https://rosettacode.org/wiki/Commatizing_numbers#Raku

    return $number.subst: :1st,
                          / <[ 1 .. 9 ]> <[ 0 .. 9 ]>* /,
                          *.flip.comb( /<{ '. ** 1..3' }>/ ).join( ',' ).flip;
}

################################################################################
