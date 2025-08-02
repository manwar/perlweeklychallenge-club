use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 312
=========================

TASK #1
-------
*Minimum Time*

Submitted by: Mohammad Sajid Anwar

You are given a typewriter with lowercase english letters a to z arranged in a
circle.

< Diagram: Task 1 >

Typing a character takes 1 sec. You can move pointer one character clockwise or
anti-clockwise.

The pointer initially points at a.

Write a script to return minimum time it takes to print the given string.

Example 1

  Input: $str = "abc"
  Output: 5

  The pointer is at 'a' initially.
  1 sec - type the letter 'a'
  1 sec - move pointer clockwise to 'b'
  1 sec - type the letter 'b'
  1 sec - move pointer clockwise to 'c'
  1 sec - type the letter 'c'

Example 2

  Input: $str = "bza"
  Output: 7

  The pointer is at 'a' initially.
  1 sec - move pointer clockwise to 'b'
  1 sec - type the letter 'b'
  1 sec - move pointer anti-clockwise to 'a'
  1 sec - move pointer anti-clockwise to 'z'
  1 sec - type the letter 'z'
  1 sec - move pointer clockwise to 'a'
  1 sec - type the letter 'a'

Example 3

  Input: $str = "zjpc"
  Output: 34

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
2. A string of lowercase letters (a-z) from the English alphabet is entered on
   the command-line.

=end comment
#===============================================================================

use Test;

my UInt constant CIRCLE      = ('a' .. 'z').elems;
my UInt constant HALF-CIRCLE = (CIRCLE / 2).floor;

subset Letters of Str where * ~~ rx/ ^ <[ a .. z ]>* $ /;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 312, Task #1: Minimum Time (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Letters:D $str                      #= A string of lowercase English letters
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my UInt $min-time = find-min-time( $str );

    "Output: $min-time".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-min-time( Letters:D $str --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $min-time = $str.chars;
    my Str  @chars    = 'a', |$str.split: '', :skip-empty;

    for 1 .. @chars.end -> UInt $i
    {
        my UInt $diff = (@chars[ $i ].ord - @chars[ $i - 1 ].ord).abs;

        $min-time    += $diff > HALF-CIRCLE ?? CIRCLE - $diff !! $diff;
    }

    return $min-time;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $expected) = $line.split: / \| /;

        for     $test-name, $str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt $min-time = find-min-time( $str );

        is $min-time, $expected, $test-name;
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
        Example 1   |abc | 5
        Example 2   |bza | 7
        Example 3   |zjpc|34
        Empty string|    | 0
        One letter  |q   |11
        No moves    |aaaa| 4
        END
}

################################################################################
