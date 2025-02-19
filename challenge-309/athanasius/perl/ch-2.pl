#!perl

################################################################################
=comment

Perl Weekly Challenge 309
=========================

TASK #2
-------
*Min Diff*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find the minimum difference between any two elements.

Example 1

  Input: @ints = (1, 5, 8, 9)
  Output: 1

  1, 5 => 5 - 1 => 4
  1, 8 => 8 - 1 => 7
  1, 9 => 9 - 1 => 8
  5, 8 => 8 - 5 => 3
  5, 9 => 9 - 5 => 4
  8, 9 => 9 - 8 => 1

Example 2

  Input: @ints = (9, 4, 1, 7)
  Output: 2

  9, 4 => 9 - 4 => 5
  9, 1 => 9 - 1 => 8
  9, 7 => 9 - 7 => 2
  4, 1 => 4 - 1 => 3
  4, 7 => 7 - 4 => 3
  1, 7 => 7 - 1 => 6

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
Differences are absolute values; therefore, the minimum difference is an unsign-
ed integer.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of 2 or more integers is entered on the command-line.

=cut
#===============================================================================

use v5.32;         # Enables strictures and warnings
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A list of 2+ integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 309, Task #2: Min Diff (Perl)\n\n";
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

        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] )
            for @ints;

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $min_diff = find_min_diff( \@ints );

        print  "Output: $min_diff\n";
    }
}

#-------------------------------------------------------------------------------
sub find_min_diff
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  %dict;

    for my $int (@$ints)
    {
        return 0 if ++$dict{ $int } > 1;
    }

    my @sorted   = sort { $b <=> $a } keys %dict;
    my $min_diff = $sorted[ 0 ] - $sorted[ 1 ];

    return 1 if $min_diff == 1;

    for my $i (1 .. $#sorted - 1)
    {
        my $diff = $sorted[ $i ] - $sorted[ $i + 1 ];

        return 1 if $diff == 1;

        $min_diff = $diff if $diff < $min_diff;
    }

    return $min_diff;
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

        my @ints     = split / \s+ /x, $ints_str;
        my $min_diff = find_min_diff( \@ints );

        is $min_diff, $expected, $test_name;
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
Example 1| 1  5  8  9   | 1
Example 2| 9  4  1  7   | 2
Identical| 4  7  9  4   | 0
Negatives|-1 -3  7  0 -2| 1
Big gaps |-5  0 42 13  7| 5
Pair     |-3 12         |15
