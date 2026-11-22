use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 400
=========================

TASK #1
-------
*Largest Interval*

Submitted by: Ali Moradi

You are given a positive integer.

Write a script that generates a sequence of integers from 1 to given positive
integer, filtering out any numbers that contain repeating digits (e.g., 11, 99,
100, and 101 are excluded) and return the biggest jump.

Example 1

  Input: $int = 20
  Output: 2

  Biggest jump between 10 and 12.

Example 2

  Input: $int = 110
  Output: 4

  Biggest jump between 98 and 102.

Example 3

  Input: $int = 500
  Output: 11

  Biggest jump between:
  a) 109 and 120 => 11
  b) 219 and 230 => 11
  c) 329 and 340 => 11
  d) 439 and 450 => 11

Example 4

  Input: $int = 2026
  Output: 105

  Biggest jump between 1098 and 1203.

Example 5

  Input: $int = 10000
  Output: 105

  The largest gap is 105, between 1098 and 1203. And again between 8796 and 
  8901.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. A positive integer is greater than zero.
2. A jump is from a number containing no repeating digits to another number con-
   taining no repeating digits. So, e.g., if $int = 11 then the maximum jump is
   1; but if $int = 12, the maximum jump is 2 (from 10 to 12).
3. If 2 or more jumps have the maximum size, only the first is detailed in the
   verbose output.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A positive integer is entered on the command-line.
3. If -v is entered on the command-line, the start and end points of the (first)
   jump with maximum size are displayed after the standard output.

=end comment
#===============================================================================

use Test;

subset Pos    of Int  where * > 0;
subset Result of List where (UInt, Pos, Pos);

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 400, Task #1: Largest Interval (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Pos:D  $int,                       #= A positive integer

    Bool:D :v($verbose) = False        #= Show start and end of max jump?
)
#===============================================================================
{
    "Input:  \$int = %s\n".printf: commify( $int );

    my (UInt $jump, Pos $start, Pos $end) = find-largest-interval( $int );

    "Output: %s\n".printf: commify( $jump );

    "\nBiggest jump between %s and %s\n".printf:
        commify( $start ), commify( $end )
            if $verbose;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-largest-interval( Pos:D $int --> Result:D )
#-------------------------------------------------------------------------------
{
    my (UInt $jump, Pos $start, Pos $end) = 0, 1, 1;
    my  Pos  $local-start = $start;

    L-OUTER: for 2 .. $int -> Pos $i
    {
        my UInt @digits = $i.split( '', :skip-empty ).map: { .Int };
        my UInt %count{UInt};

        for @digits -> UInt $d
        {
            next L-OUTER if ++%count{ $d } > 1;
        }

        my UInt $local-jump = $i - $local-start;

        if $local-jump > $jump
        {
            $jump  = $local-jump;
            $start = $local-start;
            $end   = $i;
        }

        $local-start = $i;
    }

    return $jump, $start, $end;
}

#-------------------------------------------------------------------------------
sub commify( UInt:D $n --> Str:D )
#-------------------------------------------------------------------------------
{
    return $n.subst: / (\d) <?before [\d\d\d]+ $ > /, { "$_," }, :g;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $int, $exp-jump, $exp-start, $exp-end) =
                $line.split: '|';

        for     $test-name, $int, $exp-jump, $exp-start, $exp-end
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Pos ($jump, $start, $end) = find-largest-interval( $int.Int );

        is $jump,  $exp-jump\.Int, "$test-name: jump";
        is $start, $exp-start.Int, "$test-name: start";
        is $end,   $exp-end\ .Int, "$test-name: end";
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
        Example 1|   20|  2|  10|  12
        Example 2|  110|  4|  98| 102
        Example 3|  500| 11| 109| 120
        Example 4| 2026|105|1098|1203
        Example 5|10000|105|1098|1203
        END
}

################################################################################
