#!perl

################################################################################
=comment

Perl Weekly Challenge 398
=========================

TASK #1
-------
*Divisible Average*

Submitted by: Mohammad Sajid Anwar

You are given an array of positive integers.

Write a script to return the closest integer to the mean value of all even integers that are divisible by 3. If none is divisible, return 0.

Example 1

  Input: @arr = (18, 5, 7, 11)
  Output: 18

  18 is the only even number and divisible by 3.
  Average: 18 / 1 = 18.

Example 2

  Input: @arr = (6, 12, 18, 24, 30, 40)
  Output: 18

  The qualifying numbers are 6, 12, 18, 24, and 30.
  Average: (6 + 12 + 18 + 24 + 30) / 5 = 90 / 5 = 18

Example 3

  Input: @arr = (3, 9, 15, 21, 27)
  Output: 0

  None of the elements are even.
  Since no elements qualify, return 0.

Example 4

  Input: @arr = (6, 12, 14, 20)
  Output: 9

  The qualifying numbers are 6 and 12.
  Average: (6 + 12) / 2 = 9.

Example 5

  Input: @arr = (6, 6, 6, 12, 12)
  Output: 8

  All five numbers are even and divisible by 3.
  Average: (6 + 6 + 6 + 12 + 12) / 5 = 8.4 => 8

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. The input list is not empty.
2. A "positive" integer is greater than zero.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of positive integers is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<arr> ...]
  perl $0

    [<arr> ...]    A non-empty list of positive integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 398, Task #1: Divisible Average (Perl)\n\n";
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
        for (@ARGV)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
            $_ > 0                 or error( "$_ is not positive" );
        }

        printf "Input:  \@arr = (%s)\n", join ', ', @ARGV;

        my $avg = find_divisible_average( \@ARGV );

        print  "Output: $avg\n";
    }
}

#-------------------------------------------------------------------------------
sub find_divisible_average
#-------------------------------------------------------------------------------
{
    my ($arr)  = @_;
    my  $sum   = 0;
    my  $count = 0;

    for my $n (@$arr)
    {
        if ($n % 6 == 0)
        {
            $sum += $n;
            ++$count;
        }
    }

    return $count ? int( ($sum / $count) + 0.5 ) : 0;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $arr_str, $expected) = split / \| /x, $line;

        for ($test_name, $arr_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @arr = split / \s+ /x, $arr_str;
        my $avg = find_divisible_average( \@arr );

        is $avg, $expected, $test_name;
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
Example 1|18  5  7 11      |18
Example 2| 6 12 18 24 30 40|18
Example 3| 3  9 15 21 27   | 0
Example 4| 6 12 14 20      | 9
Example 5| 6  6  6 12 12   | 8
