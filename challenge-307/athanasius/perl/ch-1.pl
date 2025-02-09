#!perl

################################################################################
=comment

Perl Weekly Challenge 307
=========================

TASK #1
-------
*Check Order*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to re-arrange the given array in an increasing order and return
the indices where it differs from the original array.

Example 1

  Input: @ints = (5, 2, 4, 3, 1)
  Output: (0, 2, 3, 4)

  Before: (5, 2, 4, 3, 1)
  After : (1, 2, 3, 4, 5)

  Difference at indices: (0, 2, 3, 4)

Example 2

  Input: @ints = (1, 2, 1, 1, 3)
  Output: (1, 3)

  Before: (1, 2, 1, 1, 3)
  After : (1, 1, 1, 2, 3)

  Difference at indices: (1, 3)

Example 3

  Input: @ints = (3, 1, 3, 2, 3)
  Output: (0, 1, 3)

  Before: (3, 1, 3, 2, 3)
  After : (1, 2, 3, 3, 3)

  Difference at indices: (0, 1, 3)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of integers is entered on the command-line.

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

    [<ints> ...]    A non-empty list of integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 307, Task #1: Check Order (Perl)\n\n";
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

        my $indices = find_diff_indices( \@ints );

        printf "Output: (%s)\n", join ', ', @$indices;
    }
}

#-------------------------------------------------------------------------------
sub find_diff_indices
#-------------------------------------------------------------------------------
{
    my ($ints)  = @_;
    my  @sorted = sort { $a <=> $b } @$ints;
    my  @indices;

    for my $i (0 .. $#$ints)
    {
        push @indices, $i unless $ints->[ $i ] == $sorted[ $i ];
    }

    return \@indices;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, $expd_str) = split / \| /x, $line;

        for ($test_name, $ints_str, $expd_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints     = split / \s+ /x, $ints_str;
        my @expected = split / \s+ /x, $expd_str;
        my $indices  = find_diff_indices( \@ints );

        is_deeply $indices, \@expected, $test_name;
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
Example 1 |5 2 4 3 1|0 2 3 4
Example 2 |1 2 1 1 3|1 3
Example 3 |3 1 3 2 3|0 1 3
No changes|1 2 3 4 5|
