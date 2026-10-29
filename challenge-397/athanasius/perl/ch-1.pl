#!perl

################################################################################
=comment

Perl Weekly Challenge 397
=========================

TASK #1
-------
*Absent Smallest Positive*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to return the smallest absent positive integer such that it is
strictly greater than the average of all elements in the given array.

Example 1

  Input: @arr = (1, 2, 4, 5, 6)
  Output: 7

  Average: (1 + 2 + 4 + 5 + 6) / 5 = 3.6
  We need the smallest positive integer absent from nums that is strictly
  greater than 3.6.
  The positive integers greater than 3.6 are 4, 5, 6, 7, ....

  4 is in the given array.
  5 is in the given array.
  6 is in the given array.
  7 is not in.

Example 2

  Input: @arr = (-5, -2, -1, 3)
  Output: 1

  Average: (-5 -2 -1 + 3) / 4 = -1.25
  We need the smallest absent positive integer strictly greater than -1.25.
  Positive integers are 1, 2, 3, 4, ... (all are strictly greater than -1.25).

  1 is positive and absent from the given array.

Example 3

  Input: @arr = (1, 2, 3)
  Output: 4

  Average: (1 + 2 + 3) / 3 = 2.0
  We need an integer strictly greater than 2.0.

  3 is in the given array.
  4 is not in.

Example 4

  Input: @arr = (2, 3, 7, 8)
  Output: 6

  Average: (2 + 3 + 7 + 8) / 4 = 5.0
  We need an integer strictly greater than 5.0.

  6 is not in the given array.

Example 5

  Input: @arr = (1, 1, 1, 10)
  Output: 4

  Average: (1 + 1 + 1 + 10) / 4 = 3.25
  Positive integers strictly greater than 3.25: 4, 5, 6, ...

  4 is not in the given array.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of integers is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use List::Util     qw( any max );
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<arr> ...]
  perl $0

    [<arr> ...]    A non-empty list of integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 397, Task #1: Absent Smallest Positive (Perl)\n\n";
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
        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] )
            for @ARGV;

        printf "Input:  \@arr = (%s)\n", join ', ', @ARGV;

        my $pos = find_absent_smallest_positive( \@ARGV );

        print  "Output: $pos\n";
    }
}

#-------------------------------------------------------------------------------
sub find_absent_smallest_positive
#-------------------------------------------------------------------------------
{
    my ($arr) = @_;
    my  $sum  = 0;
        $sum += $_ for @$arr;
    my  $avg  = $sum / scalar @$arr;
    my  $pos  = max int( $avg + 1 ), 1;

      ++$pos while any { $_ == $pos } @$arr;

    return $pos;
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
        my $pos = find_absent_smallest_positive( \@arr );

        is $pos, $expected, $test_name;
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
Example 1| 1  2  4  5 6|7
Example 2|-5 -2 -1  3  |1
Example 3| 1  2  3     |4
Example 4| 2  3  7  8  |6
Example 5| 1  1  1 10  |4
