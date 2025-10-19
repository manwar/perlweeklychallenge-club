use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 342
=========================

TASK #1
-------
*Balance String*

Submitted by: Mohammad Sajid Anwar

You are given a string made up of lowercase English letters and digits only.

Write a script to format the give[n] string where no letter is followed by
another letter and no digit is followed by another digit. If there are multiple
valid rearrangements, always return the lexicographically smallest one. Return
empty string if it is impossible to format the string.

Example 1

  Input: $str = "a0b1c2"
  Output: "0a1b2c"

Example 2

  Input: $str = "abc12"
  Output: "a1b2c"

Example 3

  Input: $str = "0a2b1c3"
  Output: "0a1b2c3"

Example 4

  Input: $str = "1a23"
  Output: ""

Example 5

  Input: $str = "ab123"
  Output: "1a2b3"

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
Digits are lexicographically "lower" than letters (as in ASCII, but not EBCDIC).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A single, non-empty string, comprising lowercase English letters and digits
   only, is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 342, Task #1: Balance String (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty string of lowercase English letters and digits

    Str:D $str where { / ^ <[ a..z 0..9 ]>+ $ / }
)
#===============================================================================
{
    qq[Input: \$str = "$str"].put;

    my Str $balanced = balance-string( $str );

    qq[Output:       "$balanced"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub balance-string
(
    Str:D $str where { / ^ <[ 0..9 a..z ]>+ $ / }
--> Str:D
)
#-------------------------------------------------------------------------------
{
    my Str (@digits, @letters);

    for $str.split( '', :skip-empty ) -> Str $char
    {
        my Str @target := $char ~~ / <[ 0..9 ]> / ?? @digits !! @letters;

        @target.push: $char;
    }

    @digits  .= sort;
    @letters .= sort;

    my Str $balanced = '';

    if    @digits.elems == @letters.elems + 1
    {
        $balanced  = @digits\.shift;
        $balanced ~= @letters.shift ~ @digits\.shift while @letters;
    }
    elsif @digits.elems == @letters.elems
    {
        $balanced ~= @digits\.shift ~ @letters.shift while @digits;
    }
    elsif @digits.elems == @letters.elems - 1
    {
        $balanced  = @letters.shift;
        $balanced ~= @digits\.shift ~ @letters.shift while @digits;
    }

    return $balanced;
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

        my Str $balanced = balance-string( $str );

        is $balanced, $expected, $test-name;
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
        Example 1|a0b1c2 |0a1b2c
        Example 2|abc12  |a1b2c
        Example 3|0a2b1c3|0a1b2c3
        Example 4|1a23   |
        Example 5|ab123  |1a2b3
        END
}

################################################################################
