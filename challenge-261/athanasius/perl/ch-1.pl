#!perl

################################################################################
=comment

Perl Weekly Challenge 261
=========================

TASK #1
-------
*Element Digit Sum*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to evaluate the absolute difference between element and digit sum
of the given array.

Example 1

  Input: @ints = (1,2,3,45)
  Output: 36

  Element Sum: 1 + 2 + 3 + 45 = 51
  Digit Sum: 1 + 2 + 3 + 4 + 5 = 15
  Absolute Difference: | 51 - 15 | = 36

Example 2

  Input: @ints = (1,12,3)
  Output: 9

  Element Sum: 1 + 12 + 3 = 16
  Digit Sum: 1 + 1 + 2 + 3 = 7
  Absolute Difference: | 16 - 7 | = 9

Example 3

  Input: @ints = (1,2,3,4)
  Output: 0

  Element Sum: 1 + 2 + 3 + 4 = 10
  Digit Sum: 1 + 2 + 3 + 4 = 10
  Absolute Difference: | 10 - 10 | = 0

Example 4

  Input: @ints = (236, 416, 336, 350)
  Output: 1296

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
2. One or more integers are given as arguments on the command-line.

Assumption
----------
For the purpose of calculating the digit sum, only digits 1 to 9 and 0 are used:
the signs "+" and "-" are ignored. However, negative numbers remain negative for
the purpose of calculating the element sum.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
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
    print "\nChallenge 261, Task #1: Element Digit Sum (Perl)\n\n";
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

        printf "Input:  \@ints = (%s)\n", join ',', @ints;

        my $diff = find_difference( \@ints );

        print  "Output: $diff\n";
    }
}

#-------------------------------------------------------------------------------
sub find_difference
#-------------------------------------------------------------------------------
{
    my ($ints)        = @_;
    my  $element_sum  = 0;
        $element_sum += $_ for @$ints;
    my  $digit_sum    = 0;

    for my $element (@$ints)
    {
        $digit_sum += $_ for grep { / ^ \d $ /x } split //, $element;
    }

    return abs( $element_sum - $digit_sum )
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

        my @ints = split / \s+ /x, $ints_str;
        my $diff = find_difference( \@ints );

        is $diff, $expected, $test_name;
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
Example 1|  1   2   3  45|  36
Example 2|  1  12   3    |   9
Example 3|  1   2   3   4|   0
Example 4|236 416 336 350|1296
Signed   | -1 +34  -2  +2|  21
