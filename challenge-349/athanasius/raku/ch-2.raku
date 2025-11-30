use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 349
=========================

TASK #2
-------
*Meeting Point*

Submitted by: Mohammad Sajid Anwar

You are given instruction string made up of U (up), D (down), L (left) and R
(right).

Write a script to return true if following the instruction, you meet (0,0) at
any point along the sequence.

Example 1

  Input: $path = "ULD"
  Output: false

  (-1,1) <- (0,1)
     |        ^
     v        |
  (-1,0)    (0,0)

Example 2

  Input: $path = "ULDR"
  Output: true

   (-1,1) <- (0,1)
      |        ^
      v        |
   (-1,0) -> (0,0)

Example 3

  Input: $path = "UUURRRDDD"
  Output: false

  (0,3) -> (1,3) -> (2,3) -> (3,3)
    ^                          |
    |                          v
  (0,2)                      (3,2)
    ^                          |
    |                          v
  (0,1)                      (3,1)
    ^                          |
    |                          v
  (0,0)                      (3,0)

Example 4

  Input: $path = "UURRRDDLLL"
  Output: true

  (0,2) -> (1,2) -> (2,2) -> (3,2)
    ^                          |
    |                          v
  (0,1)                      (3,1)
    ^                          |
    |                          v
  (0,0) <- (1,0) <- (1,1) <- (3,0)

Example 5

  Input: $path = "RRUULLDDRRUU"
  Output: true

  (0,2) <- (1,2) <- (2,2)
    |                 ^
    v                 |
  (0,1)             (2,1)
    |                 ^
    v                 |
  (0,0) -> (1,0) -> (2,1)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A single string is entered on the command-line. The string contains only the
   instructions "U" (up), "D" (down), "L" (left), and "R" (right).

=end comment
#===============================================================================

use Test;

subset Path of Str where { / ^ <[UDLR]>* $ / };

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 349, Task #2: Meeting Point (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Path:D $path              #= An instruction string made up of U, D, L, and R
)
#===============================================================================
{
    qq[Input:  \$path = "$path"].put;

    my Bool $found = find-meeting-point( $path );

    "Output: %s\n".printf: $found ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-meeting-point( Path:D $path --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Int $x = 0;
    my Int $y = 0;

    for $path.split( '', :skip-empty ) -> Str $direction
    {
        given $direction
        {
            when 'U' { ++$y }       # Up
            when 'D' { --$y }       # Down
            when 'L' { --$x }       # Left
            when 'R' { ++$x }       # Right
            default  { die qq[Impossible case: "$direction"] }
        }

        return True if $x == 0 && $y == 0;
    }

    return False;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $path, $expected) = $line.split: / \| /;

        for     $test-name, $path, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $found = find-meeting-point( $path ) ?? 'true' !! 'false';

        is $found, $expected, $test-name;
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
        Example 1|ULD         |false
        Example 2|ULDR        |true
        Example 3|UUURRRDDD   |false
        Example 4|UURRRDDLLL  |true
        Example 5|RRUULLDDRRUU|true
        Empty    |            |false
        END
}

################################################################################
