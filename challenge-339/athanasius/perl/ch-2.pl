#!perl

################################################################################
=comment

Perl Weekly Challenge 339
=========================

TASK #2
-------
*Peak Point*

Submitted by: Mohammad Sajid Anwar

You are given an array of altitude gain.

Write a script to find the peak point gained.

Example 1

  Input: @gain = (-5, 1, 5, -9, 2)
  Output: 1

  start: 0
  1st change:  0 + (-5) = -5
  2nd change: -5 + 1    = -4
  3rd change: -4 + 5    = 1
  4th change:  1 + (-9) = -8
  5th change: -8 + 2    = -6

  max(0, -5, -4, 1, -8, -6) = 1

Example 2

  Input: @gain = (10, 10, 10, -25)
  Output: 30

  start: 0
  1st change:  0 + 10    = 10
  2nd change: 10 + 10    = 20
  3rd change: 20 + 10    = 30
  4th change: 30 + (-25) = 5

  max(0, 10, 20, 30, 5) = 30

Example 3

  Input: @gain = (3, -4, 2, 5, -6, 1)
  Output: 6

  start: 0
  1st change:  0 + 3    = 3
  2nd change:  3 + (-4) = -1
  3rd change: -1 + 2    = 1
  4th change:  1 + 5    = 6
  5th change:  6 + (-6) = 0
  6th change:  0 + 1    = 1

  max(0, 3, -1, 1, 6, 0, 1) = 6

Example 4

  Input: @gain = (-1, -2, -3, -4)
  Output: 0

  start: 0
  1st change:  0 + (-1) = -1
  2nd change: -1 + (-2) = -3
  3rd change: -3 + (-3) = -6
  4th change: -6 + (-4) = -10

  max(0, -1, -3, -6, -10) = 0

Example 5

  Input: @gain = (-10, 15, 5)
  Output: 10

  start: 0
  1st change:   0 + (-10) = -10
  2nd change: -10 + 15    = 5
  3rd change:   5 + 5     = 10

  max(0, -10, 5, 10) = 10

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
Altitude gains are integers.

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
  perl $0 [<gain> ...]
  perl $0

    [<gain> ...]    A non-empty list of altitude gains (integers)
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 339, Task #2: Peak Point (Perl)\n\n";
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
        my @gain = @ARGV;

        for (@gain)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
        }

        printf "Input:  \@gain = (%s)\n", join ', ', @gain;

        my $peak = find_peak_point( \@gain );

        print  "Output: $peak\n";
    }
}

#-------------------------------------------------------------------------------
sub find_peak_point
#-------------------------------------------------------------------------------
{
    my ($gains)   = @_;
    my  $peak     = 0;
    my  $altitude = 0;     # Start

    for my $gain (@$gains)
    {
        $altitude += $gain;
        $peak      = $altitude if $altitude > $peak;
    }

    return $peak;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $gains_str, $expected) = split / \| /x, $line;

        for ($test_name, $gains_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @gain = split / \s+ /x, $gains_str;
        my $peak = find_peak_point( \@gain );

        is $peak, $expected, $test_name;
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
Example 1| -5  1  5  -9  2  | 1
Example 2| 10 10 10 -25     |30
Example 3|  3 -4  2   5 -6 1| 6
Example 4| -1 -2 -3  -4     | 0
Example 5|-10 15  5         |10
