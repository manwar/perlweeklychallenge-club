use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 202
=========================

TASK #2
-------
*Widest Valley*

Submitted by: E. Choroba

Given a profile as a list of altitudes, return the leftmost *widest valley*. A
valley is defined as a subarray of the profile consisting of two parts: the
first part is non-increasing and the second part is non-decreasing. Either part
can be empty.

Example 1

  Input: 1, 5, 5, 2, 8
  Output: 5, 5, 2, 8

Example 2

  Input: 2, 6, 8, 5
  Output: 2, 6, 8

Example 3

  Input: 9, 8, 13, 13, 2, 2, 15, 17
  Output: 13, 13, 2, 2, 15, 17

Example 4

  Input: 2, 1, 2, 1, 3
  Output: 2, 1, 2

Example 5

  Input: 1, 3, 3, 2, 1, 2, 3, 3, 2
  Output: 3, 3, 2, 1, 2, 3, 3

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If the first argument is negative, it must be preceded by "--" to distin-
   guish it from a command-line flag.

Assumption
----------
Altitudes are relative to sea level (and may therefore be negative), but are
restricted to integer values as per the Examples.

=end comment
#==============================================================================

use Test;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 202, Task #2: Widest Valley (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    *@altitudes where { .all ~~ Int:D }         #= A non-empty list of integers
)
#==============================================================================
{
    "Input:  %s\n".printf: @altitudes.join: ', ';

    my Int @valley = find-widest-valley( @altitudes );

    "Output: %s\n".printf: @valley\  .join: ', ';
}

#==============================================================================
multi sub MAIN()                                 # No input: run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
# Given a profile as a list of altitudes, return the leftmost *widest valley*.
# A valley is defined as a subarray of the profile consisting of two parts: the
# first part is non-increasing and the second part is non-decreasing. Either
# part can be empty.
#
# Example 1   Input:  1, 5, 5, 2, 8
#             Output:    5, 5, 2, 8
#
# Example 2   Input:  2, 6, 8, 5
#             Output: 2, 6, 8
#
# Example 3   Input:  9, 8, 13, 13, 2, 2, 15, 17
#             Output:       13, 13, 2, 2, 15, 17
#
# Example 4   Input:  2, 1, 2, 1, 3
#             Output: 2, 1, 2
#
# Example 5   Input:  1, 3, 3, 2, 1, 2, 3, 3, 2
#             Output:    3, 3, 2, 1, 2, 3, 3
#------------------------------------------------------------------------------
sub find-widest-valley( List:D[Int:D] $altitudes --> List:D[Int:D] )
#------------------------------------------------------------------------------
{
    my Bool $in-left = True;
    my Int  @valley  = $altitudes[ 0 ];
    my Int  @widest;

    loop (my UInt $idx = 1; $idx <= $altitudes.end; ++$idx)
    {
        my Int $last = @valley[ *-1 ];
        my Int $next = $altitudes[ $idx ];

        if    $in-left              # In the left part of the valley
        {
            @valley.push: $next;

            $in-left = False if $next > $last; # Change direction: left-->right
        }
        elsif $next >= $last        # In the right part of the valley
        {
            @valley.push: $next;
        }
        else                                   # Change direction: right-->left
        {
            # Backtrack to left-most non-ascending altitude

            --$idx while $altitudes[ $idx - 1 ] >= $altitudes[ $idx ];

            @widest  = @valley if @valley.elems > @widest.elems;
            @valley  = $altitudes[ $idx ];
            $in-left = True;
        }
    }

    @widest = @valley if @valley.elems > @widest.elems;

    return @widest;
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test, $in, $out) = $line.split: / \| /;
        my Int  @altitudes        = $in\ .split( / \, / ).map: { .Int };
        my Int  @expected         = $out\.split( / \, / ).map: { .Int };

        is-deeply find-widest-valley( @altitudes ), @expected, $test;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#------------------------------------------------------------------------------
sub test-data( --> Str:D )
#------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|1,5,5,2,8                   |5,5,2,8
        Example 2|2,6,8,5                     |2,6,8
        Example 3|9,8,13,13,2,2,15,17         |13,13,2,2,15,17
        Example 4|2,1,2,1,3                   |2,1,2
        Example 5|1,3,3,2,1,2,3,3,2           |3,3,2,1,2,3,3
        First    |5,4,3,2,4,5,4,3,1,4,5       |5,4,3,2,4,5
        Second   |10,7,3,5,9,9,8,6,4,4,3,5,7,1|9,9,8,6,4,4,3,5,7
        Negatives|3,2,0,-1,-2,4,5,3,2         |3,2,0,-1,-2,4,5
        No left  |1,2,3,4,5,3,2               |1,2,3,4,5
        No right |11,10,9,10,11,8,5,3,1,0,0   |11,8,5,3,1,0,0
        END
}

###############################################################################
