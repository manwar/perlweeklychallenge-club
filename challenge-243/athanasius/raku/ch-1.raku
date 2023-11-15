use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 243
=========================

TASK #1
-------
*Reverse Pairs*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to return the number of reverse pairs in the given array.

A reverse pair is a pair (i, j) where: a) 0 <= i < j < nums.length and b)
nums[i] > 2 * nums[j].

Example 1

  Input: @nums = (1, 3, 2, 3, 1)
  Output: 2

  (1, 4) => nums[1] = 3, nums[4] = 1, 3 > 2 * 1
  (3, 4) => nums[3] = 3, nums[4] = 1, 3 > 2 * 1

Example 2

  Input: @nums = (2, 4, 3, 5, 1)
  Output: 3

  (1, 4) => nums[1] = 4, nums[4] = 1, 4 > 2 * 1
  (2, 4) => nums[2] = 3, nums[4] = 1, 3 > 2 * 1
  (3, 4) => nums[3] = 5, nums[4] = 1, 5 > 2 * 1

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If the first integer is negative, it must be preceded by "--" to indicate
   that it is not a command-line flag.
3. If VERBOSE is set to True, the output is followed by a list of the reverse
   pairs found.

=end comment
#===============================================================================

use Test;

my Bool constant VERBOSE = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 243, Task #1: Reverse Pairs (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@nums where { .elems > 0 && .all ~~ Int:D }           #= A list of integers
)
#===============================================================================
{
    "Input:  \@nums = (%s)\n".printf: @nums.join: ', ';

    my Array[Int] @pairs = find-reverse-pairs( @nums );

    "Output: %d\n".printf: @pairs.elems;

    if VERBOSE
    {
        "\nReverse pairs: %s\n".printf:
            @pairs.map( { '(' ~ @$_.join( ', ' ) ~ ')' } ).join: ', ';
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-reverse-pairs( List:D[Int:D] $nums --> List:D[List:D[Int:D]] )
#-------------------------------------------------------------------------------
{
    my Array[Int] @pairs;

    for 0 .. $nums.end - 1 -> UInt $i
    {
        for $i + 1 .. $nums.end -> UInt $j
        {
            if $nums[ $i ] > 2 * $nums[ $j ]
            {
                @pairs.push: Array[Int].new: $i, $j;
            }
        }
    }

    return @pairs;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $nums-str, @exp-strs) = $line.split: / \| /;

        for     $test-name, $nums-str, @exp-strs
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int        @nums  = $nums-str.split( / \s+ / ).map: { .Int };
        my Array[Int] @pairs = find-reverse-pairs( @nums );
        my Array[Int] @exp;

        for @exp-strs -> Str $exp-str
        {
            @exp.push: Array[Int].new: $exp-str.split( / \s+ / ).map: { .Int };
        }

        is        @pairs.elems, @exp.elems, $test-name ~ ': count';
        is-deeply @pairs,       @exp,       $test-name ~ ': pairs';
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
        Example 1| 1 3  2  3 1|1 4|3 4
        Example 2| 2 4  3  5 1|1 4|2 4|3 4
        Negatives|-1 0 -2 -1  |0 2|0 3|1 2|1 3
        END
}

################################################################################
