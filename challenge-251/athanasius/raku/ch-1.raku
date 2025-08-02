use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 251
=========================

TASK #1
-------
*Concatenation Value*

Submitted by: Mohammad S Anwar

You are given an array of integers, @ints.

Write a script to find the concatenation value of the given array.

The concatenation of two numbers is the number formed by concatenating their
numerals.

  For example, the concatenation of 10, 21 is 1021.
  The concatenation value of @ints is initially equal to 0.
  Perform this operation until @ints becomes empty:

  If there exists more than one number in @ints, pick the first element
  and last element in @ints respectively and add the value of their
  concatenation to the concatenation value of @ints, then delete the
  first and last element from @ints.

  If one element exists, add its value to the concatenation value of
  @ints, then delete it.

Example 1

  Input: @ints = (6, 12, 25, 1)
  Output: 1286

  1st operation: concatenation of 6 and 1 is 61
  2nd operation: concaternation of 12 and 25 is 1225

  Concatenation Value => 61 + 1225 => 1286

Example 2

  Input: @ints = (10, 7, 31, 5, 2, 2)
  Output: 489

  1st operation: concatenation of 10 and 2 is 102
  2nd operation: concatenation of 7 and 2 is 72
  3rd operation: concatenation of 31 and 5 is 315

  Concatenation Value => 102 + 72 + 315 => 489

Example 3

  Input: @ints = (1, 2, 10)
  Output: 112

  1st operation: concatenation of 1 and 10 is 110
  2nd operation: only element left is 2

  Concatenation Value => 110 + 2 => 112

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
The input integers are unsigned (i.e., non-negative).

Rationale: If the right hand side of a concatenation is a negative integer, then
the result of the concatenation will not be an integer. (For example, "3" con-
catenated with "-45" gives "3-45", which is not an integer.) The simplest way to
avoid this possibility is to disallow negative numbers in the input.

Interface
---------
If no command-line arguments are given, the test suite is run.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 251, Task #1: Concatenation Value (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of unsigned integers

    *@ints where { .elems > 0 && .all ~~ UInt:D }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my UInt  $concat-value = find-concatenation-value( @ints );

    "Output: $concat-value".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-concatenation-value( List:D[UInt:D] $ints --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt @ints         = @$ints;
    my UInt $concat-value = 0;

    while @ints
    {
        # The prepended "+" operators normalize the integers; for example,
        # "+234" becomes "234"

        if @ints.elems == 1
        {
            $concat-value += +@ints.shift;
        }
        else
        {
            $concat-value += +@ints.shift ~ +@ints.pop;
        }
    }

    return $concat-value;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $expected) = $line.split: / \| /;

        for     $test-name, $ints-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt @ints         = $ints-str.split( / \s+ / ).map: { .Int };
        my UInt $concat-value = find-concatenation-value( @ints );

        is $concat-value, $expected.Int, $test-name;
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
        Example 1| 6 12 25 1    |1286
        Example 2|10  7 31 5 2 2| 489
        Example 3| 1  2 10      | 112
        END
}

################################################################################
