#!perl

################################################################################
=comment

Perl Weekly Challenge 309
=========================

TASK #1
-------
*Min Gap*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints, increasing order.

Write a script to return the element before which you find the smallest gap.

Example 1

  Input: @ints = (2, 8, 10, 11, 15)
  Output: 11

   8 - 2  => 6
  10 - 8  => 2
  11 - 10 => 1
  15 - 11 => 4

  11 is where we found the min gap.

Example 2

  Input: @ints = (1, 5, 6, 7, 14)
  Output: 6

   5 - 1 => 4
   6 - 5 => 1
   7 - 6 => 1
  14 - 7 => 7

  6 and 7 where we found the min gap, so we pick the first instance.

Example 3

  Input: @ints = (8, 20, 25, 28)
  Output: 28

   8 - 20 => 14
  25 - 20 => 5
  28 - 25 => 3

  28 is where we found the min gap.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. The input list contains at least two elements.
2. "Increasing order" means *strictly* increasing order; therefore, the smallest
   possible gap is one.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of 2 or more integers is entered on the command-line.

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

    [<ints> ...]    A list of 2+ integers in strictly increasing order
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 309, Task #1: Min Gap (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 1)
    {
        error( 'Expected 0 or 2+ command-line arguments, found 1' );
    }
    else
    {
        my @ints = @ARGV;

        / ^ $RE{num}{int} $ /x
            or error( qq["$_" is not a valid integer] )
                for @ints;

        are_increasing( \@ints )
            or error( 'The input list is not in increasing order' );

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $element = find_min_gap_elem( \@ints );

        print  "Output: $element\n";
    }
}

#-------------------------------------------------------------------------------
sub find_min_gap_elem
#-------------------------------------------------------------------------------
{
    my ($ints)        = @_;
    my  $element      = $ints->[ 1 ];
    my  $smallest_gap = $element - $ints->[ 0 ];

    for my $i (2 .. $#$ints)
    {
        my $gap = $ints->[ $i ] - $ints->[ $i - 1 ];

        if ($gap < $smallest_gap)
        {
            $smallest_gap = $gap;
            $element      = $ints->[ $i ];
        }
    }

    return $element;
}

#-------------------------------------------------------------------------------
sub are_increasing
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;

    for my $i (1 .. $#$ints)
    {
        return 0 if $ints->[ $i ] <= $ints->[ $i - 1 ];
    }

    return 1;
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

        my @ints    = split / \s+ /x, $ints_str;
        my $element = find_min_gap_elem( \@ints );

        is $element, $expected, $test_name;
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
Example 1|2  8 10 11 15|11
Example 2|1  5  6  7 14| 6
Example 3|8 20 25 28   |28
