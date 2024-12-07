#!perl

################################################################################
=comment

Perl Weekly Challenge 298
=========================

TASK #2
-------
*Right Interval*

Submitted by: Mohammad Sajid Anwar

You are given an array of @intervals, where $intervals[i] = [starti, endi] and
each starti is unique.

The right interval for an interval i is an interval j such that startj >= endi
and startj is minimized. Please note that i may equal j.

Write a script to return an array of right interval indices for each interval i.
If no right interval exists for interval i, then put -1 at index i.

Example 1

  Input: @intervals = ([3,4], [2,3], [1,2])
  Output: (-1, 0, 1)

  There is no right interval for [3,4].
  The right interval for [2,3] is [3,4] since start0 = 3 is the smallest start
  that is >= end1 = 3.
  The right interval for [1,2] is [2,3] since start1 = 2 is the smallest start
  that is >= end2 = 2.

Example 2

  Input: @intervals = ([1,4], [2,3], [3,4])
  Output: (-1, 2, -1)

  There is no right interval for [1,4] and [3,4].
  The right interval for [2,3] is [3,4] since start2 = 3 is the smallest start
  that is >= end1 = 3.

Example 3

  Input: @intervals = ([1,2])
  Output: (-1)

  There is only one interval in the collection, so it outputs -1.

Example 4

  Input: @intervals = ([1,4], [2, 2], [3, 4])
  Output: (-1, 1, -1)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of interval strings is entered on the command-line, e.g.,
   "3 4" "2 3" "1 2". Each interval string contains two integers, a start and an
   end, separated by whitespace.

Interpretation
--------------
1. In a valid interval, the end must be greater than or equal to the start.
2. The sentence "Please note that i may equal j." in the Task description means
   that an interval may be its own right interval. This is possible only when
   the start and end are equal. This interpretation is confirmed by Example 4,
   in which the interval [2, 2] is shown to be its own right interval.
3. The explanation in Example 3, "There is only one interval in the collection,
   so it outputs -1." is misleading, since a single interval in which the end
   equals the start will output 0, not -1 (as per point 2 above).

=cut
#===============================================================================

use v5.32;          # Enables strictures and warnings
use Array::Compare;
use Const::Fast;
use Regexp::Common  qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<interval-strings> ...]
  perl $0

    [<interval-strings> ...]    A list of intervals, e.g., "3 4" "2 3" "1 2"
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 298, Task #2: Right Interval (Perl)\n\n";
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
        my $intervals = read_intervals( \@ARGV );

        printf "Input:  \@intervals = (%s)\n",
                join ', ', map { '[' . join( ',', @$_ ) . ']' } @$intervals;

        my $right_intervals = find_right_intervals( $intervals );

        printf "Output: (%s)\n", join ', ', @$right_intervals;
    }
}

#-------------------------------------------------------------------------------
sub find_right_intervals
#-------------------------------------------------------------------------------
{
    my ($intervals) = @_;
    my  @right_intervals;
    my  @starts = sort { $a <=> $b } map { $_->[ 0 ] } @$intervals;

    for my $i (0 .. $#$intervals)
    {
        my  $endi = $intervals->[ $i ][ 1 ];
        my ($minj,  $min_startj);

        for my $j (0 .. $#$intervals)
        {
            my  $startj = $intervals->[ $j ][ 0 ];

            if ($startj >= $endi && (!defined $minj || $startj < $min_startj))
            {
                $min_startj = $startj;
                $minj       = $j;
            }
        }

        push @right_intervals, $minj // -1;
    }

    return \@right_intervals;
}

#-------------------------------------------------------------------------------
sub read_intervals
#-------------------------------------------------------------------------------
{
    my ($interval_strings) = @_;
    my  @intervals;
    my  %start;

    for my $str (@$interval_strings)
    {
        $str =~ / ^ \s* (\d+) \s+ (\d+) \s* $ /x
                           or  error( qq[Invalid interval "$str"] );

        my  ($start, $end) = ($1, $2);

        for ($start, $end)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
        }

        $start{ $start }++ and error( "Duplicate interval start: $start" );
        $end >= $start     or  error( "Invalid interval: [$start, $end]" );

        my $interval = [ $start, $end ];

        push @intervals, $interval;
    }

    return \@intervals;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $intervals_str, $expected_str) = split / \| /x, $line;

        for ($test_name, $intervals_str, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @int_strs   = split / \;  /x, $intervals_str;
        my $intervals  = read_intervals( \@int_strs );
        my $right_ints = find_right_intervals( $intervals );
        my @expected   = split / \s+ /x, $expected_str;

        is_deeply $right_ints, \@expected, $test_name;
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
Example 1|3 4; 2 3; 1 2|-1 0  1
Example 2|1 4; 2 3; 3 4|-1 2 -1
Example 3|1 2          |-1
Example 4|1 4; 2 2; 3 4|-1 1 -1
i == j   |7 7          | 0
