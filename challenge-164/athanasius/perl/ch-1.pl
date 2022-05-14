#!perl

###############################################################################
=comment

Perl Weekly Challenge 164
=========================

TASK #1
-------
*Prime Palindrome*

Submitted by: Mohammad S Anwar

Write a script to find all prime numbers less than 1000, which are also palin-
dromes in base 10. Palindromic numbers are numbers whose digits are the same in
reverse. For example, 313 is a palindromic prime, but 337 is not, even though
733 (337 reversed) is also prime.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Observations
------------
(1) From [1], the first 42 palindromic primes in base 10 are:
       2,     3,     5,     7,    11,   101,   131,   151,   181,   191,   313,
     353,   373,   383,   727,   757,   787,   797,   919,   929, 10301, 10501,
   10601, 11311, 11411, 12421, 12721, 12821, 13331, 13831, 13931, 14341, 14741,
   15451, 15551, 16061, 16361, 16561, 16661, 17471, 17971, 18181

(2) Also from [1]:
    "Every palindrome with an even number of digits is divisible by 11, so 11
     is the only member of the sequence with an even number of digits. - David Wasserman, Sep 09 2004"

Algorithm
---------
1. Find the primes less than 1,000 using a Sieve of Eratosthenes
2. Filter out all primes other than 11 which have an even number of digits
3. Test each prime p to determine whether it is a palindrome:
    - if every digit in p's first half matches its corresponding (i.e.,
      reflected) digit in p's second half, then p is a palindrome;
    - if any digits do not match, then p is not a palindrome
   For example, 474 is a palindrome because the first digit matches the last
   (and the middle digit matches itself)

References
----------
[1] "A002385  Palindromic primes: prime numbers whose decimal expansion is a
     palindrome.", OEIS, http://oeis.org/A002385
[2] "Palindromic prime", Wikipedia,
     https://en.wikipedia.org/wiki/Palindromic_prime
[3] "Palindromic primes", OEIS, http://oeis.org/wiki/Palindromic_primes

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;

const my $MAX   => 1_000;
const my $USAGE => "Usage:\n  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 164, Task #1: Prime Palindrome (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0
            or die "Expected 0 command line arguments, found $args\n$USAGE";

    my $primes = get_primes();
    my @pr_pals;

    for my $prime (@$primes)
    {
        push @pr_pals, $prime if is_palindrome( $prime );
    }

    printf 'The %d prime numbers less than %d which are also palindromes in ' .
           "base 10:\n%s\n", scalar @pr_pals, $MAX, join ', ', @pr_pals; 
}

#------------------------------------------------------------------------------
sub is_palindrome
#------------------------------------------------------------------------------
{
    my ($n)     = @_;
    my  @digits = split '', $n;

    for my $i (0 .. int( scalar( @digits ) / 2))
    {
        return 0 unless $digits[ $i ] == $digits[ $#digits - $i ];
    }

    return 1;
}

#------------------------------------------------------------------------------
sub get_primes                                          # Sieve of Eratosthenes
#------------------------------------------------------------------------------
{
    my @sieve = (0, 0, (1) x ($MAX - 2));
    my @primes;

    for my $n (0 .. $MAX - 1)
    {
        if ($sieve[ $n ])
        {
            push @primes, $n;

            for (my $i = $n * 2; $i < $MAX; $i += $n)
            {
                $sieve[ $i ] = 0;
            }
        }
    }

    @primes = grep { $_ == 11 || length != 2 } @primes;

    return \@primes;
}

###############################################################################
