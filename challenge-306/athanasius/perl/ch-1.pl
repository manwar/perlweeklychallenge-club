#!perl

################################################################################
=comment

Perl Weekly Challenge 306
=========================

TASK #1
-------
*Odd Sum*

Submitted by: Mohammad Sajid Anwar

You are given an array of positive integers, @ints.

Write a script to return the sum of all possible odd-length subarrays of the
given array. A subarray is a contiguous subsequence of the array.

Example 1

  Input: @ints = (2, 5, 3, 6, 4)
  Output: 77

  Odd length sub-arrays:
  (2) => 2
  (5) => 5
  (3) => 3
  (6) => 6
  (4) => 4
  (2, 5, 3) => 10
  (5, 3, 6) => 14
  (3, 6, 4) => 13
  (2, 5, 3, 6, 4) => 20

  Sum => 2 + 5 + 3 + 6 + 4 + 10 + 14 + 13 + 20 => 77

Example 2

  Input: @ints = (1, 3)
  Output: 4

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
A "positive" integer is greater than zero.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. One or more positive integers are entered on the command-line.

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

    [<ints> ...]    A non-empty list of positive integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 306, Task #1: Odd Sum (Perl)\n\n";
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
            $_ > 0                 or error( "$_ is not positive");
        }

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $odd_sum = find_odd_sum( \@ints );

        print  "Output: $odd_sum\n";
    }
}

#-------------------------------------------------------------------------------
sub find_odd_sum
#-------------------------------------------------------------------------------
{
    my ($ints)   = @_;
    my  $odd_sum = 0;

    for my $i (0 .. $#$ints)
    {
        my $sum   = 0;
        my $count = 0;

        for my $j ($i .. $#$ints)
        {
            $sum     += $ints->[ $j ];
            $odd_sum += $sum if ++$count % 2;
        }
    }

    return $odd_sum;
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

        my @ints    = split / \s+ /x, $ints_str;
        my $odd_sum = find_odd_sum( \@ints );

        is $odd_sum, $expected, $test_name;
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
Example 1|2 5 3 6 4|77
Example 2|1 3      | 4
