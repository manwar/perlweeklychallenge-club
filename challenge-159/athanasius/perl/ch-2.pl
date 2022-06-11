#!perl

###############################################################################
=comment

Perl Weekly Challenge 159
=========================

TASK #2
-------
*Moebius Number*

Submitted by: Mohammad S Anwar

You are given a positive number $n.

Write a script to generate the Moebius Number for the given number. Please
refer to wikipedia [ https://en.wikipedia.org/wiki/M%C3%B6bius_function |page]
for more informations.

Example 1:

  Input: $n = 5
  Output: -1

Example 2:

  Input: $n = 10
  Output: 1

Example 3:

  Input: $n = 20
  Output: 0

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
When the constant $VERBOSE is set to a true value (the default), the output is
followed by an explanation, e.g.:

        16:42 >perl ch-2a.pl 5

        Challenge 159, Task #2: Moebius Number (Perl)

        Input:  $n = 5
        Output: -1

        Explanation: 5 has prime factor 5^1,
                     so mu(5) = -1 because 5 is square-free
                     and has an odd number (1) of prime factors

        16:43 >

To turn off this feature, set $VERBOSE to a false value.

Definition
----------
For n ∈ N, μ(n) =
   1 if n = 1 or n is square-free and has an even number of prime factors
  −1 if          n is square-free and has an odd  number of prime factors
   0 otherwise, i.e., if n has a squared prime factor.

Algorithm
---------
If this were production code, my solution would be to simply call the moebius()
function of the CPAN module ntheory[3]. (And for the explanation, I would also
call the factor_exp() function of the same module.)

However, as this Challenge is, presumably, meant to be a learning exercise, I
have implemented the following algorithm manually:

 1. Generate a Sieve of Eratosthenes to find all primes in the range 2 to n.
 2. Find the prime factors of n by testing each prime number p (beginning with
    the smallest and working upwards) to find whether it is a factor of n
    (n mod p = 0): if it is, record it as a prime factor, divide n by p, and
    repeat the process (beginning again with p) until n = 1. The prime factors
    are returned as an AoA in which each factor is coupled with its exponent.
    E.g., the prime factors of 120 are returned as ( [2, 3], [3, 1], [5, 1] )
    denoting 2³ × 3¹ × 5¹.
 3. Analyse the prime factors of n using the definition of Moebius numbers (see
    above) to determine μ(n). Print the result.
 4. Optionally, print an explanation of the result.

References
----------
[1] "A008683  Möbius (or Moebius) function mu(n). mu(1) = 1; mu(n) = (-1)^k if
     n is the product of k different primes; otherwise mu(n) = 0.", OEIS,
     https://oeis.org/A008683
[2] "Möbius function", Wikipedia,
     https://en.wikipedia.org/wiki/M%C3%B6bius_function
[3] "Math::Prime::Util", MetaCPAN,
     https://metacpan.org/pod/Math::Prime::Util#moebius

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Devel::Assert  qw( off );
use List::Util     qw( any );
use Regexp::Common qw( number );

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 <n>

    <n>    A natural number\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 159, Task #2: Moebius Number (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $n = parse_command_line();

    print "Input:  \$n = $n\n";

    my $prime_factors = prime_factors( $n );
    my @exponents     = map { $_->[1] } @$prime_factors;

    my $mu = (any { $_ >= 2 } @exponents) ? 0 :
             (scalar @exponents % 2 == 0) ? 1 : -1;

    print "Output: $mu\n";

    explain( $n, $prime_factors, $mu ) if $VERBOSE;
}

#------------------------------------------------------------------------------
sub prime_factors
#------------------------------------------------------------------------------
{
    my ($n)    = @_;
    my  $sieve = make_sieve( $n );
    my  @factors;

    if ($sieve->[$n])                         # n is prime
    {
        push @factors, [$n, 1];
    }
    else                                      # n is non-prime (1 or composite)
    {
        my $rem = $n;

        for my $p (0 .. $#$sieve)
        {
            if ($sieve->[$p] && $rem % $p == 0)
            {
                my $exp = 0;

                $rem /= $p, ++$exp while $rem % $p == 0;

                push @factors, [$p, $exp];

                last if $rem == 1;
            }
        }

        assert $rem == 1;
    }

    return \@factors;
}

#------------------------------------------------------------------------------
sub make_sieve
#------------------------------------------------------------------------------
{
    my ($n)    =  @_;
    my  @sieve = (0, 0, (1) x ($n - 1));

    for my $i (0 .. $n)
    {
        if ($sieve[$i])
        {
            for (my $j = $i * 2; $j <= $#sieve; $j += $i)
            {
                $sieve[$j] = 0;
            }
        }
    }

    return \@sieve;
}

#------------------------------------------------------------------------------
sub explain
#------------------------------------------------------------------------------
{
    my ($n, $prime_factors, $mu) = @_;

    print "\nExplanation: ";

    if ($n == 1)
    {
        print  "1 has no prime factors; mu(1) = 1 by definition\n";
    }
    else
    {
        printf "%d has prime factor%s %s,\n             " .
               "so mu(%d) = %d because %d ",
                $n, scalar @$prime_factors == 1 ? '' : 's',
                join( '.', map { $_->[0] . '^' . $_->[1] } @$prime_factors ),
                $n, $mu, $n;

        if ($mu == 0)
        {
            my @p = grep { $_->[1] > 1 } @$prime_factors;

            assert scalar @p > 0;

            printf "has a squared prime factor (%d)\n", $p[0]->[0];
        }
        else
        {
            my $count  = 0;
               $count += $_ for map { $_->[1] } @$prime_factors;

            printf "is square-free\n             " .
                   "and has an %s number (%d) of prime factors\n",
                    $mu == 1 ? 'even' : 'odd', $count;
        }
    }
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1 or error( "Expected 1 command line argument, found $args" );

    my $n = $ARGV[0];

       $n =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$n" is not a valid integer] );

       $n > 0     or error( 'n must be greater than 0' );

    return $n;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
