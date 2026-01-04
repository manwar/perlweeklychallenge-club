#!perl

################################################################################
=comment

Perl Weekly Challenge 354
=========================

TASK #1
-------
*Min Abs Diff*

Submitted by: Mohammad Sajid Anwar

You are given an array of distinct integers.

Write a script to find all pairs of elements with the minimum absolute
difference.

  Rules (a,b):
  1: a, b are from the given array.
  2: a < b
  3: b - a = min abs diff any two elements in the given array

Example 1

  Input: @ints= (4, 2, 1, 3)
  Output: [1, 2], [2, 3], [3, 4]

Example 2

  Input: @ints = (10, 100, 20, 30)
  Output: [10, 20], [20, 30]

Example 3

  Input: @ints = (-5, -2, 0, 3)
  Output: [-2, 0]

Example 4

  Input: @ints = (8, 1, 15, 3)
  Output: [1, 3]

Example 5

  Input: @ints = (12, 5, 9, 1, 15)
  Output: [9, 12], [12, 15]

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of distinct integers is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A list of distinct integers
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 354, Task #1: Min Abs Diff (Perl)\n\n";
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

        are_distinct( \@ints ) or error( 'The input contains duplicates' );

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;
        
        my $pairs = find_min_abs_diff_pairs( \@ints );

        printf "Output: %s\n", join ', ', map { "[$_->[0], $_->[1]]" } @$pairs;
    }
}

#-------------------------------------------------------------------------------
sub find_min_abs_diff_pairs
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  @pairs;

    if (scalar @$ints > 1)
    {
        my @sorted   = sort { $a <=> $b } @$ints;
        my $min_diff = $sorted[1] - $sorted[0];

        push @pairs, [ $sorted[0], $sorted[1] ];

        for my $i (1 .. $#sorted - 1)
        {
            my $diff = $sorted[$i + 1] - $sorted[$i];

            if ($diff <= $min_diff)
            {
                if ($diff < $min_diff)
                {
                    $min_diff = $diff;
                    @pairs    = ();
                }

                push @pairs, [ $sorted[$i], $sorted[$i + 1] ];
            }
        }
    }

    return \@pairs;
}

#-------------------------------------------------------------------------------
sub are_distinct
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  %dict;

    for my $n (@$ints)
    {
        return 0 if ++$dict{$n} > 1;
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

        my  ($test_name, $ints_str, @expected_strs) = split / \| /x, $line;

        for ($test_name, $ints_str, @expected_strs)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints     = split / \s+ /x, $ints_str;
        my $pairs    = find_min_abs_diff_pairs( \@ints );
        my @expected = map { [ split / \s+ /x ] } @expected_strs;

        is_deeply $pairs, \@expected, $test_name;
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
Example 1| 4   2  1  3   | 1  2| 2  3|3 4
Example 2|10 100 20 30   |10 20|20 30
Example 3|-5  -2  0  3   |-2  0
Example 4| 8   1 15  3   | 1  3
Example 5|12   5  9  1 15| 9 12|12 15
