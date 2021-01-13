#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

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
3,325,581,707,333,960,528 (viz., 9,781 + 3,325,581,707,333,950,747) in less than
0.002 seconds!

References
----------
[1] H. A. Helfgott (2013), "The ternary Goldbach conjecture is true",
    https://arxiv.org/abs/1312.7748
[2] Tomás Oliveira e Silva (2015), "Goldbach conjecture verification",
    http://sweet.ua.pt/tos/goldbach.html
[3] Wikipedia, "Goldbach's conjecture",
    https://en.wikipedia.org/wiki/Goldbach%27s_conjecture
[4] Wikipedia, "Summation", https://en.wikipedia.org/wiki/Summation

=cut
#===============================================================================

                                                                # Exports:
use strict;
use warnings;
use Const::Fast;                                                # const()
use Math::Prime::Util qw( is_prime prev_prime prime_iterator);
use Regexp::Common    qw( number );                             # %RE{num}

use constant TIMER => 0;

const my $USAGE =>
"Usage:
  perl $0 <N>

    <N>    Summation target: integer > 1\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 076, Task #1: Prime Sum (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my  $N = parse_command_line();
    my  @primes;

    use if TIMER, 'Time::HiRes' => qw( gettimeofday tv_interval );
    my $t0 = [gettimeofday] if TIMER;

    if    (is_prime($N))                                    # Observation (3)
    {
        @primes = $N;
    }
    elsif ($N % 2 == 0)                                     # Observation (4)
    {
        @primes = find_Goldbach_partition($N);
    }
    elsif (is_prime($N - 2))                                # Observation (5.1)
    {
        @primes = (2, $N - 2);
    }
    else                                                    # Apply Strategy (2)
    {
        my $prev = prev_prime($N);
        @primes  = (find_Goldbach_partition($N - $prev), $prev);
    }

    my $t     = tv_interval($t0) if TIMER;
    my $N_str = add_commas($N);

    printf "The minimum number of prime numbers required to sum to %s is %d:\n",
            $N_str, scalar @primes;
    printf "%s = %s\n", join(' + ', map { add_commas($_) } @primes), $N_str;
    printf "\nTime taken: %.5fs\n", $t if TIMER;
}

#-------------------------------------------------------------------------------
sub find_Goldbach_partition                                       # Strategy (1)
#-------------------------------------------------------------------------------
{
    my ($N) = @_;

    $N % 2 == 0 or die "ERROR: \$N($N) must be even\n";

    my  @primes;

    if ($N == 4)
    {
        @primes = (2, 2);
    }
    else
    {
        my $it  = prime_iterator(3);
        my $max = int($N / 2);

        for (my $prime = $it->(); $prime <= $max; $prime = $it->())
        {
            if (is_prime(my $diff = $N - $prime))
            {
                @primes = ($prime, $diff);
                last;
            }
        }
    }

    my $count = scalar @primes;

    $count == 2 or die "ERROR: Expected 2 primes but found $count\n";

    return @primes;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    scalar @ARGV == 1            or die $USAGE;

    my $N =  $ARGV[0];
       $N =~ /\A$RE{num}{int}\z/ or die $USAGE;
       $N >  1                   or die $USAGE;

    return $N;
}

#-------------------------------------------------------------------------------
sub add_commas
#-------------------------------------------------------------------------------
{
    my ($number) = @_;

    # Regex from perlfaq5: "How can I output my numbers with commas added?"

    return $number =~ s/(^\d+?(?=(?>(?:\d{3})+)(?!\d))|\G\d{3}(?=\d))/$1,/gr;
}

################################################################################
