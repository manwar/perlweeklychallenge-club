#!perl

###############################################################################
=comment

Perl Weekly Challenge 157
=========================

TASK #1
-------
*Pythagorean Means*

Submitted by: Mohammad S Anwar

You are given a set of integers.

Write a script to compute all three Pythagorean Means i.e Arithmetic Mean,
Geometric Mean and Harmonic Mean of the given set of integers. Please refer to
wikipedia [ https://en.wikipedia.org/wiki/Pythagorean_means |page] for more 
informations.

Example 1:

  Input: @n = (1,3,5,6,9)
  Output: AM = 4.8, GM = 3.8, HM = 2.8

CORRECTION [2022-03-21 16:35] GM = 3.9 (before)

Example 2:

  Input: @n = (2,4,6,8,10)
  Output: AM = 6.0, GM = 5.2, HM = 4.4

Example 3:

  Input: @n = (1,2,3,4,5)
  Output: AM = 3.0, GM = 2.6, HM = 2.2

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Configuration
-------------
The number of decimal places in the three output means may be adjusted via the
$DECIMALS constant. This defaults to 1, as per the Examples.

Algorithm
---------
For a given set of integers S = { x_1, x_2, ..., x_n }, with cardinal number n:
  - the arithmetic mean =     (   x_1 + ... +   x_n ) / n
  - the geometric  mean = nth√|   x_1 * ... *   x_n |
  - the harmonic   mean = n / ( 1/x_1 + ... + 1/x_n )

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $DECIMALS => 1;
const my $USAGE    =>
"Usage:
  perl $0 [<integers> ...]

    [<integers> ...]    A set of integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 157, Task #1: Pythagorean Means (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my @n = parse_command_line();

    printf "Input:  \@n = (%s)\n", join ', ', @n;

    my $n     = scalar @n;                                    # Cardinal number

    my $sum   = 0;
       $sum  += $_ for @n;
    my $am    = $sum / $n;                                    # Arithmetic mean

    my $prod  = 1;
       $prod *= $_ for @n;
    my $gm    = abs( $prod ) ** (1 / $n);                     # Geometric  mean

       $sum   = 0;
       $sum  += $_ for map { 1 / $_ } @n;
    my $hm    = $n / $sum;                                    # Harmonic   mean

    printf "Output: AM = %.*f, GM = %.*f, HM = %.*f\n",
        $DECIMALS, $am,
        $DECIMALS, $gm,
        $DECIMALS, $hm;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    for my $n (@ARGV)
    {
        $n =~ / ^ $RE{num}{int} $ /x
            or die qq[ERROR: "$n" is not a valid integer\n$USAGE];
    }

    return @ARGV;
}

###############################################################################
