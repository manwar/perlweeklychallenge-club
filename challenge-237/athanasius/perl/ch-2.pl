#!perl

################################################################################
=comment

Perl Weekly Challenge 237
=========================

TASK #2
-------
*Maximise Greatness*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to permute the given array such that you get the maximum possible
greatness.

    To determine greatness, nums[i] < perm[i] where 0 <= i < nums.length

Example 1

  Input: @nums = (1, 3, 5, 2, 1, 3, 1)
  Output: 4

  One possible permutation: (2, 5, 1, 3, 3, 1, 1) which returns 4 greatness as
  below:
  nums[0] < perm[0]
  nums[1] < perm[1]
  nums[3] < perm[3]
  nums[4] < perm[4]

Example 2

  Input: @ints = (1, 2, 3, 4)
  Output: 3

  One possible permutation: (2, 3, 4, 1) which returns 3 greatness as below:
  nums[0] < perm[0]
  nums[1] < perm[1]
  nums[2] < perm[2]

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
2. If VERBOSE is set to a true value (the default), the output is followed by
   details of one possible permutation which gives the maximum greatness.

=cut
#===============================================================================

use v5.32.1;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 [<nums> ...]
  perl $0

    [<nums> ...]    A non-empty list of integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 237, Task #2: Maximise Greatness (Perl)\n\n";
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

        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] )
            for @nums;

        printf "Input:  \@nums =  (%s)\n",  join ', ', @nums;

        my ($max, $perm) = find_max_greatness( \@nums );

        print  "Output: $max\n";

        printf "\nOne permutation: (%s)\n", join ', ', @$perm if $VERBOSE;
    }
}

#-------------------------------------------------------------------------------
sub find_max_greatness
#-------------------------------------------------------------------------------
{
    my ($nums) = @_;
    my  $max   = 0;
    my  @from  = sort { $a <=> $b } @$nums;
    my  @to    = @from;
    my  @perm  = (undef) x scalar @$nums;

    while (@from)
    {
        my $from = pop @from;
        my $to;

        if ($to[ -1 ] > $from)
        {
            $to = pop   @to;
            ++$max;
        }
        else
        {
            $to = shift @to;
        }

        for my $i (0 .. $#$nums)
        {
            next if defined $perm[ $i ];

            if ($nums->[ $i ] == $from)
            {
                $perm[ $i ] = $to;
                last;
            }
        }
    }

    return ($max, \@perm);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $num_str, $exp, $exp_str) = split / \| /x, $line;

        for ($test_name, $num_str, $exp, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @nums = split / \s+ /x, $num_str;
        my @exp  = split / \s+ /x, $exp_str;

        my ($max, $perm) = find_max_greatness( \@nums );

        is        $max,   $exp, $test_name . ': maximum greatness';
        is_deeply $perm, \@exp, $test_name . ': permutation';
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
Example 1| 1  3  5  2 1  3 1|4| 3  5  1  3 2  1  1
Example 2| 1  2  3  4       |3| 2  3  4  1
Negatives|-1 -2 -3 -4       |3|-4 -1 -2 -3
Mixed    | 0 -1  1 -2 2 -3 3|6| 1  0  2 -1 3 -2 -3
