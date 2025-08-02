#!perl

################################################################################
=comment

Perl Weekly Challenge 252
=========================

TASK #1
-------
*Special Numbers*

Submitted by: Mohammad S Anwar

You are given an array of integers, @ints.

Write a script to find the sum of the squares of all special elements of the
given array.

  An element $int[i] of @ints is called special if i divides n, i.e. n % i == 0.
  Where n is the length of the given array. Also the array is 1-indexed for the
  task.

Example 1

  Input: @ints = (1, 2, 3, 4)
  Output: 21

  There are exactly 3 special elements in the given array:
  $ints[1] since 1 divides 4,
  $ints[2] since 2 divides 4, and
  $ints[4] since 4 divides 4.

  Hence, the sum of the squares of all special elements of given array:
  1 * 1 + 2 * 2 + 4 * 4 = 21.

Example 2

  Input: @ints = (2, 7, 1, 19, 18, 3)
  Output: 63

  There are exactly 4 special elements in the given array:
  $ints[1] since 1 divides 6,
  $ints[2] since 2 divides 6,
  $ints[3] since 3 divides 6, and
  $ints[6] since 6 divides 6.

  Hence, the sum of the squares of all special elements of given array:
  2 * 2 + 7 * 7 + 1 * 1 + 3 * 3 = 63

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A non-empty list of integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 252, Task #1: Special Numbers (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my @ints = @ARGV;

        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] )
            for @ints;

        printf "Input:  \@ints = (%s)\n",  join ', ', @ints;

        printf "Output: %d\n", sum_squares_special( \@ints );
    }
}

#-------------------------------------------------------------------------------
sub sum_squares_special
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  $sum   = 0;
    my  $n     = scalar @$ints;

    for my $i (0 .. $#$ints)
    {
        $sum += $ints->[ $i ] ** 2 if $n % ($i + 1) == 0;
    }

    return $sum;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, $expected) = split / \| /x, $line;

        for ($test_name, $ints_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints = split / \s+ /x, $ints_str;
        my $sum  = sum_squares_special( \@ints );

        is $sum, $expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1| 1  2  3  4     |  21
Example 2| 2  7  1 19 18 3|  63
Negatives|-1 -2 -3 -4     |  21
Singleton|42              |1764
