#!perl

###############################################################################
=comment

Perl Weekly Challenge 203
=========================

TASK #1
-------
*Special Quadruplets*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find out the total special quadruplets for the given array.

  Special Quadruplets are such that satisfies the following 2 rules.
  1) nums[a] + nums[b] + nums[c] == nums[d]
  2) a < b < c < d

Example 1

  Input: @nums = (1,2,3,6)
  Output: 1

  Since the only special quadruplets found is $nums[0] + $nums[1] + $nums[2] ==
  $nums[3].

Example 2

  Input: @nums = (1,1,1,3,5)
  Output: 4

  $nums[0] + $nums[1] + $nums[2] == $nums[3]
  $nums[0] + $nums[1] + $nums[3] == $nums[4]
  $nums[0] + $nums[2] + $nums[3] == $nums[4]
  $nums[1] + $nums[2] + $nums[3] == $nums[4]

Example 3

  Input: @nums = (3,3,6,4,5)
  Output: 0

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $VERBOSE is set to a true value, the special quadruplets (if any) are
   appended to the output.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 [<nums> ...]
  perl $0

    [<nums> ...]    A list of 1 or more integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 203, Task #1: Special Quadruplets (Perl)\n\n";
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

        my @quads = find_special_quadruplets( \@nums );
        my $count = scalar @quads;

        print "Output: $count\n";

        if ($VERBOSE && $count > 0)
        {
            print  "\n";
            printf "\$nums[%d] + \$nums[%d] + \$nums[%d] == \$nums[%d]\n", @$_
                for @quads;
        }
    }
}

#------------------------------------------------------------------------------
sub find_special_quadruplets
#------------------------------------------------------------------------------
{
    my ($nums) = @_;
    my  @quads;

    for my $i (0 .. $#$nums - 3)
    {
        my $elem_a = $nums->[ $i ];

        for my $j ($i + 1 .. $#$nums - 2)
        {
            my $sum_ab = $elem_a + $nums->[ $j ];

            for my $k ($j + 1 .. $#$nums - 1)
            {
                my $sum = $sum_ab + $nums->[ $k ];

                for my $l ($k + 1 .. $#$nums)
                {
                    push @quads, [ $i, $j, $k, $l ] if $sum == $nums->[ $l ];
                }
            }
        }
    }

    return @quads;
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

        my @array = split / , \s* /x, $input;
        my @quads = find_special_quadruplets( \@array );

        is scalar( @quads ), $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1|1,2,3,6  |1
Example 2|1,1,1,3,5|4
Example 3|3,3,6,4,5|0
