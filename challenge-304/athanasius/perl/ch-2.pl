#!perl

################################################################################
=comment

Perl Weekly Challenge 304
=========================

TASK #2
-------
*Maximum Average*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints and an integer, $n which is less than
or equal to total elements in the given array.

Write a script to find the contiguous subarray whose length is the given inte-
ger, $n, and has the maximum average. It should return the average.

Example 1

  Input: @ints = (1, 12, -5, -6, 50, 3), $n = 4
  Output: 12.75

  Subarray: (12, -5, -6, 50)
  Average: (12 - 5 - 6 + 50) / 4 = 12.75

Example 2

  Input: @ints = (5), $n = 1
  Output: 5

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
$n is greater than zero. (If $n = 0, calculation of the average would result in
division by zero, which is undefined. If $n < 0, the "window" would have nega-
tive length, which makes no sense.)

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A positive integer $n is entered on the command-line, followed by a non-empty
   list of integers. 0 < $n <= (the number of elements in the list).

=cut
#===============================================================================

use v5.32;         # Enables strictures and warnings
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <n> [<ints> ...]
  perl $0

    <n>             A positive integer not greater than the size of ints
    [<ints> ...]    A non-empty list of integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 304, Task #2: Maximum Average (Perl)\n\n";
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
        error( "Expected 0 or 2+ command-line arguments, found 1" )
    }
    else
    {
        my ($n, @ints) = @ARGV;

        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] )
            for $n, @ints;

        0 < $n <= scalar @ints or error( "$n is not a valid value for n" );

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $max_avg = find_max_average( \@ints, $n );

        print  "Output: $max_avg\n";
    }
}

#-------------------------------------------------------------------------------
sub find_max_average
#-------------------------------------------------------------------------------
{
    my ($ints, $n) = @_;
    my  $left      = 0;
    my  $right     = $n - 1;
    my  $total     = 0;
        $total    += $_ for @$ints[ $left .. $right ];
    my  $max       = $total;

    while ($right < $#$ints)
    {
        $total -= $ints->[   $left++ ];
        $total += $ints->[ ++$right  ];
        $max    = $total if $total > $max;
    }

    return $max / $n;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, $n, $expected) = split / \| /x, $line;

        for ($test_name, $ints_str, $n, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints    = split / \s+ /x, $ints_str;
        my $max_avg = find_max_average( \@ints, $n );

        is $max_avg, $expected, $test_name;
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
Example 1|1 12 -5 -6 50 3|4|12.75
Example 2|5              |1| 5
Repeating|1 -1  1        |3| 0.333333333333333
