use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 295
=========================

TASK #2
-------
*Jump Game*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find the minimum number of jumps to reach the last element.
$ints[$i] represents the maximum length of a forward jump from the index $i. In
case last element is unreachable then return -1.

Example 1

  Input: @ints = (2, 3, 1, 1, 4)
  Output: 2

  Jump 1 step from index 0 then 3 steps from index 1 to the last element.

Example 2

  Input: @ints = (2, 3, 0, 4)
  Output: 2

Example 3

  Input: @ints = (2, 0, 0, 4)
  Output: -1

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
The integers in the input list are unsigned (since a negative length for a for-
ward jump would indicate a backward jump, which is not within the scope of the
Task).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of unsigned integers is entered on the command-line.

Algorithm
---------
1. Construct array @from, in which each element E contains the index of the
   earliest (i.e., lowest, left-most) element in @$ints from which E can be
   reached by a direct jump.
2. Backtrack from the destination to the origin by following the indices in the
   @from array, counting the jumps.
3. If at any point in the backtrack the current element is undefined (because
   it is unreachable), -1 is returned to indicate failure. Otherwise, when the
   origin is reached, the jump count is returned.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 295, Task #2: Jump Game (Raku)\n".put;
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

    my Int $min-jumps = find-min-jumps( @ints );

    "Output: $min-jumps".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-min-jumps( List:D[UInt:D] $ints where { .elems > 0 } --> Int:D )
#-------------------------------------------------------------------------------
{
    my UInt @from;

    for 0 .. $ints.end -> UInt $i
    {
        for 1 .. $ints[ $i ] -> UInt $j
        {
            my UInt $k = $i + $j;

            last if $k > $ints.end;

            @from[ $k ] = $i unless @from[ $k ].defined;
        }
    }

    my UInt $jumps = 0;

    loop (my UInt $p = $ints.end; $p > 0; $p = @from[ $p ], ++$jumps)
    {
        return -1 unless @from[ $p ].defined;
    }

    return $jumps;
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

        my UInt @ints      = $ints-str.split( / \s+ /, :skip-empty )\
                                      .map: { .Int };
        my Int $min-jumps = find-min-jumps( @ints );

        is $min-jumps, $expected.Int, $test-name;
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
        Example 1|2 3 1 1 4| 2
        Example 2|2 3 0 4  | 2
        Example 3|2 0 0 4  |-1
        Singleton|7        | 0
        END
}

################################################################################
