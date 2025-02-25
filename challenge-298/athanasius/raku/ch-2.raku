use v6d;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

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

=end comment
#===============================================================================

use Test;

subset Interval of List where (Int, Int);

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 298, Task #2: Right Interval (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A list of intervals, e.g., "3 4" "2 3" "1 2"

    *@interval-strings where { .elems > 0 && .all ~~ Str:D }
)
#===============================================================================
{
    my Interval @intervals = read-intervals( @interval-strings );

    "Input:  \@intervals = (%s)\n".printf:
              @intervals.map( { '[' ~ @$_.join( ',' ) ~ ']' } ).join: ', ';

    my Int @right-intervals = find-right-intervals( @intervals );

    "Output: (%s)\n".printf: @right-intervals.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-right-intervals( List:D[Interval:D] $intervals --> List:D[Int:D] )
#-------------------------------------------------------------------------------
{
    my Int @right-intervals;
    my Int @starts = $intervals.map( { $_[ 0 ] } ).sort;

    for 0 .. $intervals.end -> UInt $i
    {
        my Int  $endi = $intervals[ $i; 1 ];
        my Int ($minj,  $min-startj);

        for 0 .. $intervals.end -> UInt $j
        {
            my Int $startj = $intervals[ $j; 0 ];

            if $startj >= $endi && (!$minj.defined || $startj < $min-startj)
            {
                $min-startj = $startj;
                $minj       = $j;
            }
        }

        @right-intervals.push: $minj // -1;
    }

    return @right-intervals;
}

#-------------------------------------------------------------------------------
sub read-intervals( List:D[Str:D] $interval-strings --> List:D[Interval:D] )
#-------------------------------------------------------------------------------
{
    my Interval @intervals;
    my UInt     %start{Int};

    for @$interval-strings -> Str $str
    {
        $str ~~ / ^ \s* (\d+) \s+ (\d+) \s* $ /
                           or  error( qq[Invalid interval "$str"] );

        my Int $start = +$0;
        my Int $end   = +$1;

        %start{ $start }++ and error( "Duplicate interval start: $start" );
        $end >= $start     or  error( "Invalid interval: [$start, $end]" );

        my Interval $interval = Array[Int].new: $start, $end;

        @intervals.push: $interval;
    }

    return @intervals;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $intervls-str, $expected-str) = $line.split: / \| /;

        for     $test-name, $intervls-str, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str      @int-strs   = $intervls-str.split:  / \; /, :skip-empty;
        my Interval @intervals  = read-intervals( @int-strs );
        my Int      @right-ints = find-right-intervals( @intervals );
        my Int      @expected   = $expected-str.split( / \s+ /, :skip-empty )\
                                               .map: { .Int };

        is-deeply @right-ints, @expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|3 4; 2 3; 1 2|-1 0  1
        Example 2|1 4; 2 3; 3 4|-1 2 -1
        Example 3|1 2          |-1
        Example 4|1 4; 2 2; 3 4|-1 1 -1
        i == j   |7 7          | 0
        END
}

################################################################################
