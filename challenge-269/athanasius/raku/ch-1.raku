use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 269
=========================

TASK #1
-------
*Bitwise OR*

Submitted by: Mohammad Sajid Anwar

You are given an array of positive integers, @ints.

Write a script to find out if it is possible to select two or more elements of
the given array such that the bitwise OR of the selected elements has at least
one trailing zero in its binary representation.

Example 1

  Input: @ints = (1, 2, 3, 4, 5)
  Output: true

  Say, we pick 2 and 4, their bitwise OR is 6. The binary representation of 6 is
  110. Return true since we have one trailing zero.

Example 2

  Input: @ints = (2, 3, 8, 16)
  Output: true

  Say, we pick 2 and 8, their bitwise OR is 10. The binary representation of 10
  is 1010. Return true since we have one trailing zero.

Example 3

  Input: @ints = (1, 2, 5, 7, 9)
  Output: false

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
The "positive" integers are the unsigned integers (which include zero).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of unsigned integers is entered on the command-line.
3. If VERBOSE is set to True, the output gives the result (true or false)
   followed by a brief explanation; otherwise, only the result is given.

Algorithm
---------
For bitwise OR, 0 OR 0 = 0, 0 OR 1 = 1, 1 OR 0 = 1, and 1 OR 1 = 1. Therefore,
the only way two binary operands will produce a zero as the least significant
digit when OR-ed together is if both operands end in a zero.

An unsigned integer's binary representation ends in a zero if and only if the
integer is even (i.e., divisible by 2 without remainder).

So, the algorithm is to search the input for even numbers. If two or more are
found, a solution is possible and the result is true; otherwise, no solution is
possible and the result is false.

=end comment
#===============================================================================

use Test;

my Bool constant VERBOSE = True;

subset Result of List where (UInt, UInt);

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 269, Task #1: Bitwise OR (Raku)\n".put;
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

    my Result $result = test-bitwise-OR( @ints );

    "Output: %s\n".printf: $result.defined ?? 'true' !! 'false';

    if VERBOSE
    {
        if $result.defined
        {
            my UInt $i     = $result[ 0 ];
            my UInt $j     = $result[ 1 ];
            my UInt $width = '%b'.sprintf( $j ).chars;

            "\n(%d, %d) is a solution because (%0*b OR %b) = %b\n".printf:
                $i, $j, $width, $i, $j, $i +| $j;
        }
        else
        {
            "\nThere are no solutions".put;
        }
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub test-bitwise-OR( List:D[UInt:D] $ints --> Result )
#-------------------------------------------------------------------------------
{
    my Result $result;
    my UInt   $first;

    for $ints.sort -> UInt $n
    {
        if $n %% 2
        {
            if $first.defined
            {
                $result = [$first, $n];
                last;
            }
            else
            {
                $first = $n;
            }
        }
    }

    return $result;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test, $ints-str, $exp-str, $exp1, $exp2) = $line.split: / \| /;

        for     $test, $ints-str, $exp-str, $exp1, $exp2
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt   @ints     = $ints-str.split( / \s+ /, :skip-empty )
                                       .map: { .Int };
        my Result $result   = test-bitwise-OR( @ints );
        my Bool   $expected = $exp-str eq 'true';

        is $result.defined,  $expected, "$test: Bool";

        if $result.defined
        {
            is $result[ 0 ], $exp1.Int, "$test: Op 1";
            is $result[ 1 ], $exp2.Int, "$test: Op 2";
        }
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
        Example 1| 1 2 3  4 5|true |2|4
        Example 2| 2 3 8 16  |true |2|8
        Example 3| 1 2 5  7 9|false| |
        Singleton|42         |false| |
        END
}

################################################################################
