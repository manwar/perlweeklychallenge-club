#!perl

################################################################################
=comment

Perl Weekly Challenge 302
=========================

TASK #2
-------
*Step by Step*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find the minimum positive start value such that step by step
sum is never less than one.

Example 1

  Input: @ints = (-3, 2, -3, 4, 2)
  Output: 5

  For start value 5.
  5 + (-3) = 2
  2 + (+2) = 4
  4 + (-3) = 1
  1 + (+4) = 5
  5 + (+2) = 7

Example 2

  Input: @ints = (1, 2)
  Output: 1

Example 3

  Input: @ints = (1, -2, -3)
  Output: 5

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
From Example 2, it appears that the start value is included in the steps, from
which it follows that the minimum *possible* start value is 1.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of integers is entered on the command-line.

=cut
#===============================================================================

use v5.32;         # Enables strictures and warnings
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
    print "\nChallenge 302, Task #2: Step by Step (Perl)\n\n";
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

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $start = find_min_start( \@ints );

        print  "Output: $start\n";
    }
}

#-------------------------------------------------------------------------------
sub find_min_start
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  $start = 1;

    for my $n (reverse @$ints)
    {
        $start -= $n;
        $start  = 1 if $start < 1;
    }

    return $start;
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

        my @ints  = split / \s+ /x, $ints_str;
        my $start = find_min_start( \@ints );

        is $start, $expected, $test_name;
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
Example 1|-3  2 -3 4 2|5
Example 2| 1  2       |1
Example 3| 1 -2 -3    |5
