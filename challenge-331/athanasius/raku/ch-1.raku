use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 331
=========================

TASK #1
-------
*Last Word*

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to find the length of last word in the given string.

Example 1

  Input: $str = "The Weekly Challenge"
  Output: 9

Example 2

  Input: $str = "   Hello   World    "
  Output: 5

Example 3

  Input: $str = "Let's begin the fun"
  Output: 3

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
2. A string is entered on the command-line.

Assumption
----------
All non-word characters, including punctuation, are to be handled like the
whitespace in the Examples.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 331, Task #1: Last Word (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str                           #= A string
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my UInt $length = find-last-word-len( $str );

    "Output: $length".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-last-word-len( Str:D $str --> UInt:D )
#-------------------------------------------------------------------------------
{
    $str ~~ / (\w+) \W* $ /;

    return ($0 // '').chars;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $ignore, $expected) = $line.split: / \| /;

        for     $test-name, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt $length = find-last-word-len( $str );

        is $length, $expected.Int, $test-name;
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
        Example 1|The Weekly Challenge|               | 9
        Example 2|   Hello   World    |               | 5
        Example 3|Let's begin the fun|                | 3
        Question |Is this a good question?|           | 8
        Empty    ||                                   | 0
        No words |. ### //??? * &&& ! #/?*|           | 0
        Long word|Supercalifragilisticexpialidocious!||34
        END
}

################################################################################
