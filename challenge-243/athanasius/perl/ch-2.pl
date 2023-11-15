#!perl

################################################################################
=comment

Perl Weekly Challenge 243
=========================

TASK #2
-------
*Floor Sum*

Submitted by: Mohammad S Anwar

You are given an array of positive integers (>=1).

Write a script to return the sum of floor(nums[i] / nums[j]) where 0 <= i,j <
nums.length. The floor() function returns the integer part of the division.

Example 1

  Input: @nums = (2, 5, 9)
  Output: 10

  floor(2 / 5) = 0
  floor(2 / 9) = 0
  floor(5 / 9) = 0
  floor(2 / 2) = 1
  floor(5 / 5) = 1
  floor(9 / 9) = 1
  floor(5 / 2) = 2
  floor(9 / 2) = 4
  floor(9 / 5) = 1

Example 2

  Input: @nums = (7, 7, 7, 7, 7, 7, 7)
  Output: 49

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

=cut
#===============================================================================

use v5.32.1;          # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 [<nums> ...]
  perl $0

    [<nums> ...]    A list of positive integers (>= 1)\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 243, Task #2: Floor Sum (Perl)\n\n";
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
        my $nums = parse_command_line();

        printf "Input:  \@nums = (%s)\n", join ', ', @$nums;

        my $sum  = floor_sum( $nums );

        print  "Output: $sum\n";
    }
}

#-------------------------------------------------------------------------------
sub floor_sum
#-------------------------------------------------------------------------------
{
    my ($nums) = @_;
    my  $sum   = 0;

    for my $i (0 .. $#$nums)
    {
        for my $j (0 .. $#$nums)
        {
            # int() is equivalent to floor() when the argument is known to be
            # positive

            $sum += int( $nums->[ $i ] / $nums->[ $j ] );
        }
    }

    return $sum;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    for (@ARGV)
    {
        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );

        $_ >= 1                or error( qq["$_" is not positive (>= 1)] );
    }

    return \@ARGV;
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
        my $sum  = floor_sum( \@nums );

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
Example 1|2 5 9               | 10
Example 2|7 7 7 7 7 7 7       | 49
Series   |1 2 3 4 5 6 7 8 9 10|127
