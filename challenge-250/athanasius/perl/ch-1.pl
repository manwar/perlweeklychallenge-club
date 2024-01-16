#!perl

################################################################################
=comment

Perl Weekly Challenge 250
=========================

TASK #1
-------
*Smallest Index*

Submitted by: Mohammad S Anwar

You are given an array of integers, @ints.

Write a script to find the smallest index i such that i mod 10 == $ints[i]
otherwise return -1.

Example 1

  Input: @ints = (0, 1, 2)
  Output: 0

  i=0: 0 mod 10 = 0 == $ints[0].
  i=1: 1 mod 10 = 1 == $ints[1].
  i=2: 2 mod 10 = 2 == $ints[2].
  All indices have i mod 10 == $ints[i], so we return the smallest index 0.

Example 2

  Input: @ints = (4, 3, 2, 1)
  Output: 2

  i=0: 0 mod 10 = 0 != $ints[0].
  i=1: 1 mod 10 = 1 != $ints[1].
  i=2: 2 mod 10 = 2 == $ints[2].
  i=3: 3 mod 10 = 3 != $ints[3].
  2 is the only index which has i mod 10 == $ints[i].

Example 3

  Input: @ints = (1, 2, 3, 4, 5, 6, 7, 8, 9, 0)
  Output: -1
  Explanation: No index satisfies i mod 10 == $ints[i].

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Note
----
Negative numbers are allowed in the input. However, as array indices are never
negative, the expression i mod 10 is never negative, and so the equality
i mod 10 = ints[i] can never be satisfied when the array element ints[i] is
negative.

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
    print "\nChallenge 250, Task #1: Smallest Index (Perl)\n\n";
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

        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] )
            for @ints;

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $smallest_index = find_smallest_index( \@ints );

        print  "Output: $smallest_index\n";
    }
}

#-------------------------------------------------------------------------------
sub find_smallest_index
#-------------------------------------------------------------------------------
{
    my ($ints)          = @_;
    my  $smallest_index = -1;

    for my $i (0 .. $#$ints)
    {
        if ($i % 10 == $ints->[ $i ])
        {
            $smallest_index = $i;
            last;
        }
    }

    return $smallest_index;
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

        my @ints           = split / \s+ /x, $ints_str;
        my $smallest_index = find_smallest_index( \@ints );

        is $smallest_index, $expected, $test_name;
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
Example 1|0 1 2                 | 0
Example 2|4 3 2   1             | 2
Example 3|1 2 3   4 5  6 7 8 9 0|-1
Negatives|1 2 3 -17 0 -5        |-1
