#!perl

###############################################################################
=comment

Perl Weekly Challenge 171
=========================

TASK #1
-------
*Abundant Number*

Submitted by: Mohammad S Anwar

Write a script to generate first 20 Abundant Odd Numbers.

According to [ https://en.wikipedia.org/wiki/Abundant_number |wikipedia],


    A number n for which the sum of divisors σ(n) > 2n, or, equivalently, the
    sum of proper divisors (or aliquot sum) s(n) > n.


For example, 945 is the first Abundant Odd Number.

  Sum of divisors:
  1 + 3 + 5 + 7 + 9 + 15 + 21 + 27 + 35 + 45 + 63 + 105 + 135 + 189 + 315 = 975

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Configuration
-------------
Set $VERBOSE to a true value to display the proper divisors and their sum for
each abundant odd number found.

Algorithm
---------
For the verbose output, an integer's divisors are obtained using the divisors()
routine from the CPAN module Math::Prime::Util (aka ntheory). For the standard
output, the same module's divisor_sum() routine is used instead for a more
direct solution.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Math::Prime::Util qw( divisor_sum divisors );

const my $TARGET  => 20;
const my $USAGE   => "Usage:\n  perl $0\n";
const my $VERBOSE =>  0;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 171, Task #1: Abundant Number (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0
            or die "Expected 0 command line arguments, found $args\n$USAGE";

    my $abundant = $VERBOSE ? solve_with_divisors() : solve_with_sum();

    printf "The first %d abundant odd numbers:\n%s\n",
            $TARGET, join +($VERBOSE ? "\n" : ', '), @$abundant;
}

#------------------------------------------------------------------------------
sub solve_with_sum
#------------------------------------------------------------------------------
{
    my @abundant;

    for (my $n = 1; scalar @abundant < $TARGET; $n += 2)
    {
        push @abundant, $n if divisor_sum( $n ) > 2 * $n;
    }

    return \@abundant;
}

#------------------------------------------------------------------------------
sub solve_with_divisors
#------------------------------------------------------------------------------
{
    my @abundant;
    my $count = 0;

    for (my $n = 1; $count < $TARGET; $n += 2)
    {
        my  @divisors = divisors( $n );
        pop @divisors;
        my  $sum  = 0;
            $sum += $_ for @divisors;

        if ($sum > $n)
        {
            push @abundant, sprintf "%2d. %4d: %s = %d",
                                    ++$count, $n, join( '+', @divisors ), $sum;
        }
    }

    return \@abundant;
}

###############################################################################
