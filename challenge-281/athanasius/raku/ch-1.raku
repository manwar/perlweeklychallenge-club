use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 281
=========================

TASK #1
-------
*Check Color*

Submitted by: Mohammad Sajid Anwar

You are given coordinates, a string that represents the coordinates of a square
of the chessboard as shown below:

  8 │ │╳│ │╳│ │╳│ │╳│
  7 │╳│ │╳│ │╳│ │╳│ │
  6 │ │╳│ │╳│ │╳│ │╳│
  5 │╳│ │╳│ │╳│ │╳│ │
  4 │ │╳│ │╳│ │╳│ │╳│
  3 │╳│ │╳│ │╳│ │╳│ │
  2 │ │╳│ │╳│ │╳│ │╳│
  1 │╳│ │╳│ │╳│ │╳│ │
     a b c d e f g h

  Week_281_Task_1

Write a script to return true if the square is light, and false if the square is
dark.

Example 1

  Input: $coordinates = "d3"
  Output: true

Example 2

  Input: $coordinates = "g5"
  Output: false

Example 3

  Input: $coordinates = "e6"
  Output: true

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
2. The input coordinates are entered as a single, two-character string on the
   command-line.

Algorithm
---------
Let the files "a" through "h" be numbered 1 through 8. Then, by inspection, the
dark squares occur where the file and rank are either both odd or both even.
Conversely, the light squares occur where either the file is odd and the rank is
even, or the file is even and the rank is odd.

=end comment
#===============================================================================

use Test;

subset Coords of Str where / ^ <[ a .. h ]> <[ 1 .. 8 ]> $ /;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 281, Task #1: Check Color (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| Coordinates identifying a chessboard square, e.g., "d3"

    Coords:D $coordinates
)
#===============================================================================
{
    qq[Input:  \$coordinates = "$coordinates"].put;

    my Bool $is-light = square-is-light( $coordinates );

    "Output: %s\n".printf: $is-light ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub square-is-light( Coords:D $coordinates --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Str ($file-s, $rank) =  $coordinates.split: '', :skip-empty;
    my UInt $file           =  $file-s.ord - 'a'.ord + 1;
    my Bool $file-is-even   =  $file %% 2;
    my Bool $rank-is-even   = +$rank %% 2;

    return  $file-is-even  ?? !$rank-is-even
                           !!  $rank-is-even;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $coords, $expected) = $line.split: / \| /;

        for     $test-name, $coords, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Bool $is-light = square-is-light( $coords );

        is $is-light, $expected eq 'true', $test-name;
    }

    done-testing;
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
        Example 1|d3|true
        Example 2|g5|false
        Example 3|e6|true
        END
}

################################################################################
