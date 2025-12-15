#!perl

################################################################################
=comment

Perl Weekly Challenge 351
=========================

TASK #1
-------
*Special Average*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to return the average excluding the minimum and maximum of the
given array.

Example 1

  Input: @ints = (8000, 5000, 6000, 2000, 3000, 7000)
  Output: 5250

  Min: 2000
  Max: 8000
  Avg: (3000+5000+6000+7000)/4 = 21000/4 = 5250

Example 2

  Input: @ints = (100_000, 80_000, 110_000, 90_000)
  Output: 95_000

  Min: 80_000
  Max: 110_000
  Avg: (100_000 + 90_000)/2 = 190_000/2 = 95_000

Example 3

  Input: @ints = (2500, 2500, 2500, 2500)
  Output: 0

  Min: 2500
  Max: 2500
  Avg: 0

Example 4

  Input: @ints = (2000)
  Output: 0

  Min: 2000
  Max: 2000
  Avg: 0

Example 5

  Input: @ints = (1000, 2000, 3000, 4000, 5000, 6000)
  Output: 3500

  Min: 1000
  Max: 6000
  Avg: (2000 + 3000 + 4000 + 5000)/4 = 14000/4 = 3500

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
    print "\nChallenge 351, Task #1: Special Average (Perl)\n\n";
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

        my $average = find_special_average( \@ints );

        print "Output: $average\n";
    }
}

#-------------------------------------------------------------------------------
sub find_special_average
#-------------------------------------------------------------------------------
{
    my ($ints)   = @_;
    my  $average = 0;

    if (scalar @$ints > 2)
    {
        my @sorted = sort { $a <=> $b } @$ints;
        my $min    = $sorted[ 0];
        my $max    = $sorted[-1];

        shift @sorted while scalar @sorted > 0 && $sorted[ 0] == $min;
        pop   @sorted while scalar @sorted > 0 && $sorted[-1] == $max;

        if (scalar @sorted > 0)
        {
            my $sum  = 0;
               $sum += $_ for @sorted;

            $average = $sum / (scalar @sorted);
        }
    }

    return $average;
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
        my $average = find_special_average( \@ints );

        is $average, $expected, $test_name;
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
Example 1|  8000  5000   6000  2000 3000 7000| 5250
Example 2|100000 80000 110000 90000          |95000
Example 3|  2500  2500   2500  2500          |    0
Example 4|  2000                             |    0
Example 5|  1000  2000   3000  4000 5000 6000| 3500
