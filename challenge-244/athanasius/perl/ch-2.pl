#!perl

################################################################################
=comment

Perl Weekly Challenge 244
=========================

TASK #2
-------
*Group Hero*

Submitted by: Mohammad S Anwar

You are given an array of integers representing the strength.

Write a script to return the sum of the powers of all possible combinations;
power is defined as the square of the largest number in a sequence, multiplied
by the smallest.

Example 1

  Input: @nums = (2, 1, 4)
  Output: 141

  Group 1: (2) => square(max(2)) * min(2) => 4 * 2 => 8
  Group 2: (1) => square(max(1)) * min(1) => 1 * 1 => 1
  Group 3: (4) => square(max(4)) * min(4) => 16 * 4 => 64
  Group 4: (2,1) => square(max(2,1)) * min(2,1) => 4 * 1 => 4
  Group 5: (2,4) => square(max(2,4)) * min(2,4) => 16 * 2 => 32
  Group 6: (1,4) => square(max(1,4)) * min(1,4) => 16 * 1 => 16
  Group 7: (2,1,4) => square(max(2,1,4)) * min(2,1,4) => 16 * 1 => 16

  Sum: 8 + 1 + 64 + 4 + 32 + 16 + 16 => 141

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. Duplicates are allowed in the input list.
2. Combinations are unordered and unique, but may contain duplicates. So, (1, 2)
   and (2, 1) are the same combination, BUT (1, 2) and (1, 2, 2) are different
   combinations (and so must be counted separately).

Interface
---------
If no command-line arguments are given, the test suite is run.

=cut
#===============================================================================

use v5.32.1;          # Enables strictures
use warnings;
use Const::Fast;
use List::Util        qw( any max min uniqnum );
use Math::Prime::Util qw( forcomb );
use Regexp::Common    qw( number );
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 [<nums> ...]
  perl $0

    [<nums> ...]    A list of integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 244, Task #2: Group Hero (Perl)\n\n";
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

        printf "Input:  \@nums = (%s)\n", join ', ', @nums;

        my $sum = power_sum( \@nums );

        print  "Output: $sum\n";
    }
}

#-------------------------------------------------------------------------------
sub power_sum
#-------------------------------------------------------------------------------
{
    my ($nums) = @_;
    my  @set   = sort { $a <=> $b } uniqnum @$nums;
    my  @combs;
    my  %groups;

    forcomb { push @combs, [ @set[ @_ ] ] } @set;

    for my $comb (@combs)
    {
        next if scalar @$comb == 0;

        my $key = join '|', @$comb;

        $groups{ $key } = power( $comb );
    }

    my $sum = 0;
    my %counts;
     ++$counts{ $_ } for @$nums;

    for my $key (keys %groups)
    {
        my @comb = split / \| /x, $key;
        my $mult = 1;

        for my $num (keys %counts)
        {
            $mult *= $counts{ $num } if any { $num == $_ } @comb;
        }

        $sum += $groups{ $key } * $mult;
    }

    return $sum;
}

#-------------------------------------------------------------------------------
sub power
#-------------------------------------------------------------------------------
{
    my ($comb) = @_;
    my  @nums  = @$comb;
    my  $max   = max @nums;
    my  $min   = min @nums;

    return $max * $max * $min;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $nums_str, $exp_str) = split / \| /x, $line;

        for ($test_name, $nums_str, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @nums = split / \s+ /x, $nums_str;
        my $sum  = power_sum( \@nums );

        is $sum, $exp_str, $test_name;
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
Example 1  | 2  1  4      |141
Multiples 1| 1  1  2 2    | 34
Multiples 2| 2  1  4 1 2 1|315
