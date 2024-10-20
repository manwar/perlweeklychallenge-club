#!perl

################################################################################
=comment

Perl Weekly Challenge 291
=========================

TASK #1
-------
*Middle Index*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find the leftmost middle index (MI) i.e. the smallest amongst
all the possible ones.

    A middle index is an index where ints[0] + ints[1] + … + ints[MI-1] ==
    ints[MI+1] + ints[MI+2] + … + ints[ints.length-1].

  If MI == 0, the left side sum is considered to be 0. Similarly,
  if MI == ints.length - 1, the right side sum is considered to be 0.

Return the leftmost MI that satisfies the condition, or -1 if there is no such
index.

Example 1

  Input: @ints = (2, 3, -1, 8, 4)
  Output: 3

  The sum of the numbers before index 3 is: 2 + 3 + -1 = 4
  The sum of the numbers after index 3 is: 4 = 4

Example 2

  Input: @ints = (1, -1, 4)
  Output: 2

  The sum of the numbers before index 2 is: 1 + -1 = 0
  The sum of the numbers after index 2 is: 0

Example 3

  Input: @ints = (2, 5)
  Output: -1

  There is no valid MI.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of integers is entered on the command-line.

=cut
#===============================================================================

use v5.32;         # Enables strictures
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
    print "\nChallenge 291, Task #1: Middle Index (Perl)\n\n";
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

        for (@ints)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
        }

        printf qq[Input:  \@ints = (%s)\n], join ', ', @ints;

        my $m_idx = find_middle_index( \@ints );

        print "Output: $m_idx\n";
    }
}

#-------------------------------------------------------------------------------
sub find_middle_index
#-------------------------------------------------------------------------------
{
    my ($ints)      = @_;
    my  $left_sum   = 0;
    my  $right_sum  = 0;
        $right_sum += $ints->[ $_ ] for 1 .. $#$ints;

    for my $i (0 .. $#$ints - 1)
    {
        return $i if $left_sum == $right_sum;

        $left_sum  += $ints->[ $i     ];
        $right_sum -= $ints->[ $i + 1 ];
    }

    return $left_sum == 0 ? $#$ints : -1;
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
        my $m_idx = find_middle_index( \@ints );

        is $m_idx, $expected, $test_name;
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
Example 1|2  3 -1 8 4| 3
Example 2|1 -1  4    | 2
Example 3|2  5       |-1
Left  idx|5 -2 -3 0 5| 0
Right idx|6 -4 -3 1 7| 4
