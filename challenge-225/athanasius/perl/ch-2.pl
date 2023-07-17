#!perl

################################################################################
=comment

Perl Weekly Challenge 225
=========================

TASK #2
-------
*Left Right Sum Diff*

Submitted by: Mohammad S Anwar

You are given an array of integers, @ints.

Write a script to return left right sum diff array as shown below:

  @ints = (a, b, c, d, e)

  @left  = (0, a, (a+b), (a+b+c))
  @right = ((c+d+e), (d+e), e, 0)
  @left_right_sum_diff = ( | 0 - (c+d+e) |,
                           | a - (d+e)   |,
                           | (a+b) - e   |,
                           | (a+b+c) - 0 | )

Example 1:

  Input: @ints = (10, 4, 8, 3)
  Output: (15, 1, 11, 22)

  @left  = (0, 10, 14, 22)
  @right = (15, 11, 3, 0)

  @left_right_sum_diff = ( |0-15|, |10-11|, |14-3|, |22-0|)
                       = (15, 1, 11, 22)

Example 2:

  Input: @ints = (1)
  Output: (0)

  @left  = (0)
  @right = (0)

  @left_right_sum_diff = ( |0-0| ) = (0)

Example 3:

  Input: @ints = (1, 2, 3, 4, 5)
  Output: (14, 11, 6, 1, 10)

  @left  = (0, 1, 3, 6, 10)
  @right = (14, 12, 9, 5, 0)

  @left_right_sum_diff = ( |0-14|, |1-12|, |3-9|, |6-5|, |10-0|)
                       = (14, 11, 6, 1, 10)

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
2. It $VERBOSE is set to a true value, the required output (the left-right-sum-
   diff array) is followed by the left and right arrays.

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A non-empty list of integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 225, Task #2: Left Right Sum Diff (Perl)\n\n";
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

        printf "Input:   \@ints = (%s)\n", join ', ', @ints;

        my $solution = find_left_right_sum_diff( \@ints );

        printf "Output:  (%s)\n", join ', ', @{ $solution->{ lrsd } };

        if ($VERBOSE)
        {
            printf "\n\@left  = (%s)\n", join ', ', @{ $solution->{ left  } };
            printf   "\@right = (%s)\n", join ', ', @{ $solution->{ right } };
        }
    }
}

#-------------------------------------------------------------------------------
sub find_left_right_sum_diff
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  $end   = $#$ints;
    my  @left  = 0;
    my  @right = 0;
    my  @lrsd;
    my  %solution;

    $left [ $_ ] = $left [ $_ - 1 ] + $ints->[        $_ - 1 ] for 1 .. $end;
    $right[ $_ ] = $right[ $_ - 1 ] + $ints->[ $end - $_ + 1 ] for 1 .. $end;
    @right       = reverse @right;
    $lrsd [ $_ ] = abs( $left[ $_ ] - $right[ $_ ] )           for 0 .. $end;

    $solution{ left  } = \@left;
    $solution{ right } = \@right;
    $solution{ lrsd  } = \@lrsd;

    return \%solution;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, $left_str, $rght_str, $lrsd_str) =
             split / \| /x, $line;

        for ($test_name, $ints_str, $left_str, $rght_str, $lrsd_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints = split / \s+ /x, $ints_str;
        my @left = split / \s+ /x, $left_str;
        my @rght = split / \s+ /x, $rght_str;
        my @lrsd = split / \s+ /x, $lrsd_str;
        my $soln = find_left_right_sum_diff( \@ints );

        is_deeply $soln->{ left  }, \@left, "$test_name: left";
        is_deeply $soln->{ right }, \@rght, "$test_name: right";
        is_deeply $soln->{ lrsd  }, \@lrsd, "$test_name: left-right-sum-diff";
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
Example 1| 10 4  8   3|  0 10 14 22|   15 11   3 0|   15  1 11 22
Example 2|           1|           0|             0|             0
Example 3|1 2 3  4   5|0 1  3  6 10|14 12  9   5 0|14 11  6  1 10
Negatives|    6 -4 -12|     0  6  2|     -16 -12 0|      16 18  2
