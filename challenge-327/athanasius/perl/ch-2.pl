#!perl

################################################################################
=comment

Perl Weekly Challenge 327
=========================

TASK #2
-------
*MAD*

Submitted by: Mohammad Sajid Anwar

You are given an array of distinct integers.

Write a script to find all pairs of elements with minimum absolute difference
(MAD) of any two elements.

Example 1

  Input: @ints = (4, 1, 2, 3)
  Output: [1,2], [2,3], [3,4]

  The minimum absolute difference is 1.
  Pairs with MAD: [1,2], [2,3], [3,4]

Example 2

  Input: @ints = (1, 3, 7, 11, 15)
  Output: [1,3]

Example 3

  Input: @ints = (1, 5, 3, 8)
  Output: [1,3], [3,5]

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
2. A non-empty list of distinct integers is entered on the command-line.

Note
----
Since the input integers are distinct, the smallest possible MAD is 1.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use List::Util     qw( min );
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A non-empty list of distinct integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 327, Task #2: MAD (Perl)\n\n";
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
            / ^ $RE{num}{int} $ /x
                           or error( qq["$_" is not a valid integer] )
        }

        distinct( \@ints ) or error( 'The input integers are not distinct' );

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $mad_pairs = find_MAD_pairs( \@ints );

        printf "Output: %s\n",
                join ', ', map { sprintf '[%d,%d]', @$_ } @$mad_pairs;
    }
}

#-------------------------------------------------------------------------------
sub find_MAD_pairs
#-------------------------------------------------------------------------------
{
    my ($ints)  = @_;
    my  @sorted = sort { $a <=> $b } @$ints;
    my  %ab_diff;

    for my $i (0 .. $#sorted - 1)
    {
        my $lhs  = $sorted[ $i     ];
        my $rhs  = $sorted[ $i + 1 ];
        my $diff = $rhs - $lhs;

        push @{ $ab_diff{ $diff } }, [ $lhs, $rhs ];
    }

    my $mad = min keys %ab_diff;

    return $ab_diff{ $mad };
}

#-------------------------------------------------------------------------------
sub distinct
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  %count;

    for (@$ints)
    {
        return 0 if ++$count{ $_ } > 1;
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

        my  ($test_name, $ints_str, @exp_strs) = split / \| /x, $line;

        for ($test_name, $ints_str, @exp_strs)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints      = split / \s+ /x, $ints_str;
        my $mad_pairs = find_MAD_pairs( \@ints );
        my @expected;

        for my $exp_pair (@exp_strs)
        {
            push @expected, [ split / \s+ /x, $exp_pair ];
        }

        is_deeply $mad_pairs, \@expected, $test_name;
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
Example 1|4 1 2  3   |1 2|2 3|3 4
Example 2|1 3 7 11 15|1 3
Example 3|1 5 3  8   |1 3|3 5
