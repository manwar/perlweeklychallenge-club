#!perl

################################################################################
=comment

Perl Weekly Challenge 322
=========================

TASK #2
-------
*Rank Array*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to return an array of the ranks of each element: the lowest value
has rank 1, next lowest rank 2, etc. If two elements are the same then they
share the same rank.

Example 1

  Input: @ints = (55, 22, 44, 33)
  Output: (4, 1, 3, 2)

Example 2

  Input: @ints = (10, 10, 10)
  Output: (1, 1, 1)

Example 3

  Input: @ints = (5, 1, 1, 4, 3)
  Output: (4, 1, 1, 3, 2)

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
use List::Util     qw( uniqint );
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
    print "\nChallenge 322, Task #2: Rank Array (Perl)\n\n";
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

        my $ranks = find_ranks( \@ints );

        printf "Output: (%s)\n",          join ', ', @$ranks;
    }
}

#-------------------------------------------------------------------------------
sub find_ranks
#-------------------------------------------------------------------------------
{
    my ($ints)  = @_;
    my  @sorted = uniqint sort { $a <=> $b } @$ints;
    my  %rank;

    for my $i (0 .. $#sorted)
    {
        $rank{ $sorted[ $i ] } = $i + 1;
    }

    my @ranks;

    for my $i (0 .. $#$ints)
    {
        push @ranks, $rank{ $ints->[ $i ] };
    }

    return \@ranks;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, $expected_str) = split / \| /x, $line;

        for ($test_name, $ints_str, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints     = split / \s+ /x, $ints_str;
        my $ranks    = find_ranks( \@ints );
        my @expected = split / \s+ /x, $expected_str;

        is_deeply $ranks, \@expected, $test_name;
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
Example 1|55 22 44 33  |4 1 3 2
Example 2|10 10 10     |1 1 1
Example 3| 5  1  1  4 3|4 1 1 3 2
