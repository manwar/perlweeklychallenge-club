use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 340
=========================

TASK #2
-------
*Ascending Numbers*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str, is a list of tokens separated by a single space.
Every token is either a positive number consisting of digits 0-9 with no leading
zeros, or a word consisting of lowercase English letters.

Write a script to check if all the numbers in the given string are strictly
increasing from left to right.

Example 1

  Input: $str = "The cat has 3 kittens 7 toys 10 beds"
  Output: true

  Numbers 3, 7, 10 - strictly increasing.

Example 2

  Input: $str = 'Alice bought 5 apples 2 oranges 9 bananas'
  Output: false

Example 3

  Input: $str = 'I ran 1 mile 2 days 3 weeks 4 months'
  Output: true

Example 4

  Input: $str = 'Bob has 10 cars 10 bikes'
  Output: false

Example 5

  Input: $str = 'Zero is 0 one is 1 two is 2'
  Output: true

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
2. A single string is entered on the command-line. The string comprises a space-
   separated list of words and numbers.

Notes
-----
1. The requirement that a word token "consist[s] of lowercase English letters"
   is contradicted by the first word in every Example. I have broadened the
   requirement to just "English letters" (of either case).
2. When an input token is found which does not match the requirements for either
   a number or a word, a warning is issued and the token is ignored.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 340, Task #2: Ascending Numbers (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A string comprising a space-separated list of words and numbers

    Str:D $str
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my Bool $ascending = check-ascending( $str );

    "Output: %s\n".printf: $ascending ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub check-ascending( Str:D $str --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Int $last-num = -1;

    for $str.split( / \s+ /, :skip-empty ) -> Str $token
    {
        if    $token  ~~ / ^ ( 0 || <[ 1..9 ]> \d* ) $ /
        {
            my UInt $num = $0.Int;

            return False unless $num > $last-num;

            $last-num = $num;
        }
        elsif $token !~~ / ^ <[ A..Z a..z ]>+ $ /
        {
            qq[WARNING: Ignoring invalid token "$token"].put;
        }
    }

    return True;
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

        my Bool $ascending = check-ascending( $str );
        my Str  $asc-str   = $ascending ?? 'true' !! 'false';

        is $asc-str, $expected, $test-name;
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
        Example 1|The cat has 3 kittens 7 toys 10 beds     |true
        Example 2|Alice bought 5 apples 2 oranges 9 bananas|false
        Example 3|I ran 1 mile 2 days 3 weeks 4 months     |true
        Example 4|Bob has 10 cars 10 bikes                 |false
        Example 5|Zero is 0 one is 1 two is 2              |true
        END
}

################################################################################
