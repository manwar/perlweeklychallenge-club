#!perl

################################################################################
=comment

Perl Weekly Challenge 320
=========================

TASK #2
-------
*Sum Difference*

Submitted by: Mohammad Sajid Anwar

You are given an array of positive integers.

Write a script to return the absolute difference between digit sum and element
sum of the given array.

Example 1

  Input: @ints = (1, 23, 4, 5)
  Output: 18

  Element sum: 1 + 23 + 4 + 5 => 33
  Digit sum: 1 + 2 + 3 + 4 + 5 => 15
  Absolute difference: | 33 - 15 | => 18

Example 2

  Input: @ints = (1, 2, 3, 4, 5)
  Output: 0

  Element sum: 1 + 2 + 3 + 4 + 5 => 15
  Digit sum: 1 + 2 + 3 + 4 + 5 => 15
  Absolute difference: | 15 - 15 | => 0

Example 3

  Input: @ints = (1, 2, 34)
  Output: 27

  Element sum: 1 + 2 + 34 => 37
  Digit sum: 1 + 2 + 3 + 4 => 10
  Absolute difference: | 37 - 10 | => 27

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
A "positive" integer is greater than or equal to zero (i.e., unsigned).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of unsigned integers is entered on the command-line.

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

    [<ints> ...]    A non-empty list of unsigned integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 320, Task #2: Sum Difference (Perl)\n\n";
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
        for (@ARGV)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
            $_ >= 0                or error( "$_ is not a positive integer" );
        }

        my @ints = map { $_ + 0 } @ARGV;        # Normalize (remove initial "+")

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $sum_diff = find_sum_diff( \@ints );

        print  "Output: $sum_diff\n";
    }
}

#-------------------------------------------------------------------------------
sub find_sum_diff
#-------------------------------------------------------------------------------
{
    my ($ints)       = @_;
    my  $element_sum = 0;
    my  $digit_sum   = 0;

    for my $int (@$ints)
    {
        $element_sum += $int;
        $digit_sum   += $_ for split //, $int;
    }

    return abs( $element_sum - $digit_sum );
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $int_str, $expected) = split / \| /x, $line;

        for ($test_name, $int_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints     = split / \s+ /x, $int_str;
        my $sum_diff = find_sum_diff( \@ints );

        is $sum_diff, $expected, $test_name;
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
Example 1|1 23  4 5  |18
Example 2|1  2  3 4 5| 0
Example 3|1  2 34    |27
Include 0|1 23  4 0 5|18
