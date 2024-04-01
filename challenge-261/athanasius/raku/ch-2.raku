use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 261
=========================

TASK #2
-------
*Multiply by Two*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints and an integer $start..

Write a script to do the followings:

  a) Look for $start in the array @ints, if found multiply the number by 2
  b) If not found stop the process otherwise repeat

In the end return the final value.

Example 1

  Input: @ints = (5,3,6,1,12) and $start = 3
  Output: 24

  Step 1: 3 is in the array so 3 x 2 = 6
  Step 2: 6 is in the array so 6 x 2 = 12
  Step 3: 12 is in the array so 12 x 2 = 24

  24 is not found in the array so return 24.

Example 2

  Input: @ints = (1,2,4,3) and $start = 1
  Output: 8

  Step 1: 1 is in the array so 1 x 2 = 2
  Step 2: 2 is in the array so 2 x 2 = 4
  Step 3: 4 is in the array so 4 x 2 = 8

  8 is not found in the array so return 8.

Example 3

  Input: @ints = (5,6,7) and $start = 2
  Output: 2

  2 is not found in the array so return 2.

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
2. The starting integer is given on the command-line as a named argument,
   followed by a (possibly empty) list of integers.
3. If the first integer in the list (i.e., following the start integer) on the
   command-line is negative, it must be preceded by "--" to indicate that it is
   not a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 261, Task #2: Multiply by Two (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Int:D :$start,                              #= The starting integer
          *@ints where { .all ~~ Int:D }        #= A list of integers
)
#===============================================================================
{
    "Input:  \@ints = (%s) and start = %d\n".printf: @ints.join( ',' ), $start;

    "Output: %d\n".printf: find-final-value( @ints, $start );
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-final-value( List:D[Int:D] $ints, Int:D $start --> Int:D )
#-------------------------------------------------------------------------------
{
    my Int $value = $start;

    if $start ≠ 0
    {
        $value *= 2 while $value == $ints.any;
    }

    return $value;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $start-str, $expected) =
                $line.split: / \| /;

        for     $test-name, $ints-str, $start-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int @ints  = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int $value = find-final-value( @ints, $start-str.Int );

        is $value, $expected.Int, $test-name;
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
        Example 1  |5  3  6  1 12  | 3|24
        Example 2  |1  2  4  3     | 1| 8
        Example 3  |5  6  7        | 2| 2
        Negatives  |7 -2  0 -1  3  |-1|-4
        Repetitions|4  8 16  4 32 8| 4|64
        Zero start |9 -3  1 17  0  | 0| 0
        Empty list |               |42|42
        END
}

################################################################################
