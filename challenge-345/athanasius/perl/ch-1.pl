#!perl

################################################################################
=comment

Perl Weekly Challenge 345
=========================

TASK #1
-------
*Peak Positions*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Find all the peaks in the array, a peak is an element that is strictly greater
than its left and right neighbours. Return the indices of all such peak posi-
tions.

Example 1

  Input: @ints = (1, 3, 2)
  Output: (1)

Example 2

  Input: @ints = (2, 4, 6, 5, 3)
  Output: (2)

Example 3

  Input: @ints = (1, 2, 3, 2, 4, 1)
  Output: (2, 4)

Example 4

  Input: @ints = (5, 3, 1)
  Output: (0)

Example 5

  Input: @ints = (1, 5, 1, 5, 1, 5, 1)
  Output: (1, 3, 5)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
From Example 4, it appears that an integer in either end position is considered
to be "strictly greater than" its non-existent neighbour.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of integers is entered on the command-line.

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

    [<ints> ...]    A non-empty list of integers
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 345, Task #1: Peak Positions (Perl)\n\n";
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

        my $peaks = find_peaks( \@ints );

        printf "Output: (%s)\n", join ', ', @$peaks;
    }
}

#-------------------------------------------------------------------------------
sub find_peaks
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  $size  = scalar @$ints;
    my  @peaks;

    if    ($size == 0)
    {
        die 'Empty integer list';
    }
    elsif ($size == 1)
    {
        push @peaks, 0;
    }
    else
    {
        my $e = $#$ints;

        push @peaks, 0      if $ints->[0]  > $ints->[1];

        for my $i (1 .. $e - 1)
        {
            push @peaks, $i if $ints->[$i] > $ints->[$i - 1] &&
                               $ints->[$i] > $ints->[$i + 1]
        }

        push @peaks, $e     if $ints->[$e] > $ints->[$e - 1];
    }

    return \@peaks;
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

        my @ints  = split / \s+ /x, $ints_str;
        my $peaks = find_peaks( \@ints );
        my @expd  = split / \s+ /x, $expd_str;

        is_deeply $peaks, \@expd, $test_name;
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
Example 1|1 3 2        |1
Example 2|2 4 6 5 3    |2
Example 3|1 2 3 2 4 1  |2 4
Example 4|5 3 1        |0
Example 5|1 5 1 5 1 5 1|1 3 5
Singleton|4            |0
Negatives|0 -1 1 -2 0  |0 2 4
