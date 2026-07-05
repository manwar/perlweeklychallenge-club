use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 380
=========================

TASK #2
-------
*Reverse Degree*

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to find the reverse degree of the given string.

  For each character, multiply its position in the reversed alphabet ('a' = 26,
  'b' = 25, ..., 'z' = 1) with its position in the string. Sum these products
  for all characters in the string to get the reverse degree.

Example 1

  Input: $str = "z"
  Output: 1

  Reverse alphabet value of "z" is 1.
  Position 1: 1 x 1
  Sum of product: 1

Example 2

  Input: $str = "a"
  Output: 26

  Reverse alphabet value of "a" is 26.
  Position 1: 1 x 26
  Sum of product: 26

Example 3

  Input: $str = "bbc"
  Output: 147

  Reverse alphabet value of "b" is 25 and "c" is 24.
  Position 1: 1 x 25
  Position 2: 2 x 25
  Position 3: 3 x 24
  Sum of product: 25 + 50 + 72 => 147

Example 4

  Input: $str = "racecar"
  Output: 560

  Reverse alphabet value of "r" is 9, "a" is 26, "c" is 24 and "e" is 24.
  Position 1: 1 x 9
  Position 2: 2 x 26
  Position 3: 3 x 24
  Position 4: 4 x 22
  Position 5: 5 x 24
  Position 6: 6 x 26
  Position 7: 7 x 9
  Sum of product: 9 + 52 + 72 + 88 + 120 + 156 + 63

Example 5

  Input: $str = "zyx"
  Output: 14

  Reverse alphabet value of "z" is 1, "y" is 2 and "x" is 3.
  Position 1: 1 x 1
  Position 2: 2 x 2
  Position 3: 3 x 3
  Sum of product: 1 + 4 + 9

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A single string is entered on the command-line.

Assumption
----------
The mapping of letters to values is the same for upper- as for lower-case:
    'A', 'a' => 26,
    'B', 'b' => 25,
          ...
    'Z', 'z' =>  1.

=end comment
#===============================================================================

use Test;

my Map constant REV-ALPHA = Map.new: 'a' .. 'z' Z (26 ... 1);

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 380, Task #2: Reverse Degree (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str where m:i/ ^ <[ a .. z ]>* $ /             #= A string of letters
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my UInt $degree = find-reverse-degree( $str );

    "Output: $degree".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-reverse-degree( Str:D $str where m:i/ ^ <[ a .. z ]>* $ / --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $sum = 0;
    my UInt $i   = 1;

    for $str.split: '', :skip-empty -> Str $char
    {
        $sum += REV-ALPHA{ $char.lc } * $i++;
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
        my Str ($test-name, $str, $expected) = $line.split: '|';

        for     $test-name, $str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt $degree = find-reverse-degree( $str );

        is $degree, $expected.Int, $test-name;
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
        Example 1 |z      |  1
        Example 2 |a      | 26
        Example 3 |bbc    |147
        Example 4 |racecar|560
        Example 5 |zyx    | 14
        Upper case|ZYX    | 14
        Empty     |       |  0
        END
}

################################################################################
