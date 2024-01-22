use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 252
=========================

TASK #1
-------
*Special Numbers*

Submitted by: Mohammad S Anwar

You are given an array of integers, @ints.

Write a script to find the sum of the squares of all special elements of the
given array.

  An element $int[i] of @ints is called special if i divides n, i.e. n % i == 0.
  Where n is the length of the given array. Also the array is 1-indexed for the
  task.

Example 1

  Input: @ints = (1, 2, 3, 4)
  Output: 21

  There are exactly 3 special elements in the given array:
  $ints[1] since 1 divides 4,
  $ints[2] since 2 divides 4, and
  $ints[4] since 4 divides 4.

  Hence, the sum of the squares of all special elements of given array:
  1 * 1 + 2 * 2 + 4 * 4 = 21.

Example 2

  Input: @ints = (2, 7, 1, 19, 18, 3)
  Output: 63

  There are exactly 4 special elements in the given array:
  $ints[1] since 1 divides 6,
  $ints[2] since 2 divides 6,
  $ints[3] since 3 divides 6, and
  $ints[6] since 6 divides 6.

  Hence, the sum of the squares of all special elements of given array:
  2 * 2 + 7 * 7 + 1 * 1 + 3 * 3 = 63

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
2. If the first command-line argument is negative, it must be preceded by "--"
   to distinguish it from a command-line switch.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 252, Task #1: Special Numbers (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list if integers

    *@ints where { .elems > 0 && .all ~~ Int:D }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    "Output: %d\n".printf: sum-squares-special( @ints );
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub sum-squares-special( List:D[Int:D] $ints where { .elems > 0 } --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $sum = 0;
    my UInt $n   = $ints.elems;

    for 0 .. $ints.end -> UInt $i
    {
        $sum += $ints[ $i ]² if $n %% ($i + 1);
    }

    return $sum;
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

        my Int  @ints = $ints-str.split( / \s+ / ).map: { .Int };
        my UInt $sum  = sum-squares-special( @ints );

        is $sum, $expected.Int, $test-name;
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
        Example 1| 1  2  3  4     |  21
        Example 2| 2  7  1 19 18 3|  63
        Negatives|-1 -2 -3 -4     |  21
        Singleton|42              |1764
        END
}

################################################################################
