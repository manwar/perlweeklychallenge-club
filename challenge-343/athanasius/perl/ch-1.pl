#!perl

################################################################################
=comment

Perl Weekly Challenge 343
=========================

TASK #1
-------
*Zero Friend*

Submitted by: Mohammad Sajid Anwar

You are given a list of numbers.

Find the number that is closest to zero and return its distance to zero.

Example 1

  Input: @nums = (4, 2, -1, 3, -2)
  Output: 1

  Values closest to 0: -1 and 2 (distance = 1 and 2)

Example 2

  Input: @nums = (-5, 5, -3, 3, -1, 1)
  Output: 1

  Values closest to 0: -1 and 1 (distance = 1)

Example 3

  Input: @ums = (7, -3, 0, 2, -8)
  Output: 0

  Values closest to 0: 0 (distance = 0)
  Exact zero wins regardless of other close values.

Example 4

  Input: @nums = (-2, -5, -1, -8)
  Output: 1

  Values closest to 0: -1 and -2 (distance = 1 and 2)

Example 5

  Input: @nums = (-2, 2, -4, 4, -1, 1)
  Output: 1

  Values closest to 0: -1 and 1 (distance = 1)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
The input numbers are integers.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of integers is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<nums> ...]
  perl $0

    [<nums> ...]    A non-empty list of integers
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 343, Task #1: Zero Friend (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my @nums = @ARGV;

        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] )
            for @nums;

        printf "Input:  \@nums = (%s)\n", join ', ', @nums;

        my $min_dist = find_min_distance( \@nums );

        print  "Output: $min_dist\n";
    }
}

#-------------------------------------------------------------------------------
sub find_min_distance
#-------------------------------------------------------------------------------
{
    my ($nums)    = @_;
    my  @abs_nums = map  { abs( $_ ) } @$nums;
        @abs_nums = sort { $a <=> $b } @abs_nums;

    return $abs_nums[0];
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $nums_str, $expected) = split / \| /x, $line;

        for ($test_name, $nums_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @nums     = split / \s+ /x, $nums_str;
        my $min_dist = find_min_distance( \@nums );

        is $min_dist, $expected, $test_name;
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
Example 1| 4  2 -1  3 -2  |1
Example 2|-5  5 -3  3 -1 1|1
Example 3| 7 -3  0  2 -8  |0
Example 4|-2 -5 -1 -8     |1
Example 5|-2  2 -4  4 -1 1|1
