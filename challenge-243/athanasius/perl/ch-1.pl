#!perl

################################################################################
=comment

Perl Weekly Challenge 243
=========================

TASK #1
-------
*Reverse Pairs*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to return the number of reverse pairs in the given array.

A reverse pair is a pair (i, j) where: a) 0 <= i < j < nums.length and b)
nums[i] > 2 * nums[j].

Example 1

  Input: @nums = (1, 3, 2, 3, 1)
  Output: 2

  (1, 4) => nums[1] = 3, nums[4] = 1, 3 > 2 * 1
  (3, 4) => nums[3] = 3, nums[4] = 1, 3 > 2 * 1

Example 2

  Input: @nums = (2, 4, 3, 5, 1)
  Output: 3

  (1, 4) => nums[1] = 4, nums[4] = 1, 4 > 2 * 1
  (2, 4) => nums[2] = 3, nums[4] = 1, 3 > 2 * 1
  (3, 4) => nums[3] = 5, nums[4] = 1, 5 > 2 * 1

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $VERBOSE is set to a true value, the output is followed by a list of the
   reverse pairs found.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 [<nums> ...]
  perl $0

    [<nums> ...]    A list of integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 243, Task #1: Reverse Pairs (Perl)\n\n";
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
        my @nums = @ARGV;

        for (@nums)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
        }

        printf "Input:  \@nums = (%s)\n", join ', ', @nums;

        my $pairs = find_reverse_pairs( \@nums );

        printf "Output: %d\n", scalar @$pairs;

        if ($VERBOSE)
        {
            printf "\nReverse pairs: %s\n",
                join ', ', map { '(' . join( ', ', @$_ ) . ')' } @$pairs;
        }
    }
}

#-------------------------------------------------------------------------------
sub find_reverse_pairs
#-------------------------------------------------------------------------------
{
    my ($nums) = @_;
    my  @pairs;

    for my $i (0 .. $#$nums - 1)
    {
        for my $j ($i + 1 .. $#$nums)
        {
            if ($nums->[ $i ] > 2 * $nums->[ $j ])
            {
                push @pairs, [ $i, $j ];
            }
        }
    }

    return \@pairs;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $nums_str, @exp_strs) = split / \| /x, $line;

        for ($test_name, $nums_str, @exp_strs)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @nums  = split / \s+ /x, $nums_str;
        my $pairs = find_reverse_pairs( \@nums );
        my @exp;

        for my $exp_str (@exp_strs)
        {
            push @exp, [ split / \s+ /x, $exp_str ];
        }

        is  scalar @$pairs, scalar  @exp, $test_name . ': count';
        is_deeply \@$pairs,        \@exp, $test_name . ': pairs';
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
Example 1| 1 3  2  3 1|1 4|3 4
Example 2| 2 4  3  5 1|1 4|2 4|3 4
Negatives|-1 0 -2 -1  |0 2|0 3|1 2|1 3
