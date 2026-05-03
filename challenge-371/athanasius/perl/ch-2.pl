#!perl

################################################################################
=comment

Perl Weekly Challenge 371
=========================

TASK #2
-------
*Subset Equilibrium*

Submitted by: Mohammad Sajid Anwar

You are given an array of numbers.

Write a script to find all proper subsets with more than one element where the
sum of elements equals the sum of their indices.

Example 1

  Input: @nums = (2, 1, 4, 3)
  Output: (2, 1), (1, 4), (4, 3), (2, 3)

  Subset 1: (2, 1)
  Values: 2 + 1 = 3
  Positions: 1 + 2 = 3

  Subset 2: (1, 4)
  Values: 1 + 4 = 5
  Positions: 2 + 3 = 5

  Subset 3: (4, 3)
  Values: 4 + 3 = 7
  Positions: 3 + 4 = 7

  Subset 4: (2, 3)
  Values: 2 + 3 = 5
  Positions: 1 + 4 = 5

Example 2

  Input: @nums = (3, 0, 3, 0)
  Output: (3, 0), (3, 0, 3)

  Subset 1: (3, 0)
  Values: 3 + 0 = 3
  Positions: 1 + 2 = 3

  Subset 2: (3, 0, 3)
  Values: 3 + 0 + 3 = 6
  Positions: 1 + 2 + 3 = 6

Example 3

  Input: @nums = (5, 1, 1, 1)
  Output: (5, 1, 1)

  Subset 1: (5, 1, 1)
  Values: 5 + 1 + 1 = 7
  Positions: 1 + 2 + 4 = 7

Example 4

  Input: @nums = (3, -1, 4, 2)
  Output: (3, 2), (3, -1, 4)

  Subset 1: (3, 2)
  Values: 3 + 2 = 5
  Positions: 1 + 4 = 5

  Subset 2: (3, -1, 4)
  Values: 3 + (-1) + 4 = 6
  Positions: 1 + 2 + 3 = 6

Example 5

  Input: @nums = (10, 20, 30, 40)
  Output: ()

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

Assumptions
-----------
1. The input numbers are integers.
2. Within the solution, subsets are ordered by cardinal number, ascending. With-
   in each group with the same cardinal number, subsets are ordered by first in-
   dex, then by second index, etc., all ascending. Therefore the solution given
   in Example 1 is wrongly ordered; it should be:

     Input: @nums = (2, 1, 4, 3)
     Output: (2, 1), (2, 3), (1, 4), (4, 3)

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Algorithm::Combinatorics qw( combinations );
use Const::Fast;
use List::Util               qw( sum0 );
use Regexp::Common           qw( number );
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
    print "\nChallenge 371, Task #2: Subset Equilibrium (Perl)\n\n";
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

        for my $num (@nums)
        {
            $num =~ / ^ $RE{num}{int} $ /x
                    or error( qq["$num" is not a valid integer] );
        }

        printf "Input:  \@nums = (%s)\n", join ', ', @nums;

        my $subsets = find_subsets( \@nums );

        printf "Output: %s\n", scalar @$subsets == 0 ? '()' :
                join ', ', map { '(' . join( ', ', @$_ ) . ')' } @$subsets;
    }
}

#-------------------------------------------------------------------------------
sub find_subsets
#-------------------------------------------------------------------------------
{
    my ($nums) = @_;
    my  $size  = scalar @$nums;
    my  @subsets;

    for my $element_count (2 .. $size - 1)
    {
        my $iter = combinations( [ 0 .. $size - 1 ], $element_count );

        while (my $comb = $iter->next)
        {
            my $value_sum    = sum0( @$nums[ @$comb ] );
            my $position_sum = sum0( map { $_ + 1 } @$comb );

            if ($value_sum == $position_sum)
            {
                push @subsets, [ @$nums[ @$comb ] ];
            }
        }
    }

    return \@subsets;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $nums_str, @exp_strs) = split / \| /x, $line;

        for ($test_name, $nums_str, @exp_strs)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @nums    = split / \s+ /x, $nums_str;
        my $subsets = find_subsets( \@nums );
        my @expected;

        for my $exp_str (@exp_strs)
        {
            push @expected, [ split / \s+ /x, $exp_str ];
        }

        is_deeply $subsets, \@expected, $test_name;
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
Example 1| 2  1  4  3|2 1|2 3|1 4|4 3
Example 2| 3  0  3  0|3 0|3 0 3
Example 3| 5  1  1  1|5 1 1
Example 4| 3 -1  4  2|3 2|3 -1 4
Example 5|10 20 30 40|
