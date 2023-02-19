#!perl

###############################################################################
=comment

Perl Weekly Challenge 204
=========================

TASK #1
-------
*Monotonic Array*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find out if the given array is Monotonic. Print 1 if it is
otherwise 0.

    An array is Monotonic if it is either monotone increasing or decreasing.

  Monotone increasing: for i <= j , nums[i] <= nums[j]
  Monotone decreasing: for i <= j , nums[i] >= nums[j]

Example 1

  Input: @nums = (1,2,2,3)
  Output: 1

Example 2

  Input: @nums (1,3,2)
  Output: 0

Example 3

  Input: @nums = (6,5,5,4)
  Output: 1

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;
use enum           qw( Flat Up Down );

const my $USAGE =>
"Usage:
  perl $0 [<nums> ...]
  perl $0

    [<nums> ...]    A list of 1 or more integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 204, Task #1: Monotonic Array (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my @nums = @ARGV;

        / ^ $RE{num}{int} $ /x
            or die qq[ERROR: "$_" is not a valid integer\n$USAGE]
                for @nums;

        printf "Input:  \@array = (%s)\n", join ',', @nums;

        printf "Output: %d\n", is_monotonic( \@nums );
    }
}

#------------------------------------------------------------------------------
sub is_monotonic
#------------------------------------------------------------------------------
{
    my ($nums) = @_;
    my  $dir   = Flat;
    my  $last  = $nums->[ 0 ];

    for my $i (1 .. $#$nums)
    {
        my $next = $nums->[ $i ];

        if    ($next > $last)
        {
            return 0 if $dir == Down;

            $dir = Up;
        }
        elsif ($next < $last)
        {
            return 0 if $dir == Up;

            $dir = Down;
        }

        $last = $next;
    }

    return 1;
}

#------------------------------------------------------------------------------
sub run_tests
#------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($test_name, $input, $expected) = split / \| /x, $line;

        my @nums = split / , \s* /x, $input;
        my $got  = is_monotonic( \@nums );

        is $got, $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1  | 1, 2, 2, 3          |1
Example 2  | 1, 3, 2             |0
Example 3  | 6, 5, 5, 4          |1
Flat       | 4, 4, 4, 4          |1
Negatives 1|-1,-1,-2,-2,-4,-5    |1
Negatives 2|-1,-1,-2,-2,-4,-3    |0
Single     |42                   |1
Mixed 1    |-5,-2, 0, 0, 1, 3,5,5|1
Mixed 2    |-5,-2,-3,-1, 0, 4,6  |0
