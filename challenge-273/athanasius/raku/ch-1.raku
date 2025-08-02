use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 273
=========================

TASK #1
-------
*Percentage of Character*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str and a character $char.

Write a script to return the percentage, nearest whole, of given character in
the given string.

Example 1

  Input: $str = "perl", $char = "e"
  Output: 25

Example 2

  Input: $str = "java", $char = "a"
  Output: 50

Example 3

  Input: $str = "python", $char = "m"
  Output: 0

Example 4

  Input: $str = "ada", $char = "a"
  Output: 67

Example 5

  Input: $str = "ballerina", $char = "l"
  Output: 22

Example 6

  Input: $str = "analitik", $char = "k"
  Output: 13

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
2. The input string and character are entered as unnamed (positional) arguments
   on the command-line.
3. If "--ignore-case" is entered on the command-line, "X" and "x" (for example)
   are treated as the same character; otherwise, the default behaviour is to
   treat them as different characters.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 273, Task #1: Percentage of Character (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D   $str,                          #= A string
    Str:D   $char where { .chars == 1 },   #= A character
    Bool:D :$ignore-case = False           #= "X" and "x" are the same character
)
#===============================================================================
{
    qq[Input:  \$str = "$str", \$char = "$char"].put;

    my UInt $percent = find-percentage( $str, $char, $ignore-case );

    "Output: $percent".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-percentage
(
    Str:D  $str,                                                  #= A string
    Str:D  $orig-char where { .chars == 1 },                      #= A character
    Bool:D $ignore-case                  #= "X" and "x" are different characters
--> UInt:D
)
#-------------------------------------------------------------------------------
{
    return 0 if $str.chars == 0;                        # Avoid division by zero

    my UInt $count = 0;
    my Str  $char  = $ignore-case ?? $orig-char.lc !! $orig-char;

    for $str.split: '', :skip-empty -> Str $orig-c
    {
        my Str $c  = $ignore-case ?? $orig-c.lc    !! $orig-c;

        ++$count if $c eq $char;
    }

    return (($count / $str.chars) * 100).round;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $char, $ignore-case-str, $expected) =
                $line.split: / \| /;

        for     $test-name, $str, $char, $ignore-case-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Bool $ignore-case = $ignore-case-str eq 'True';
        my UInt $percent     = find-percentage( $str, $char, $ignore-case );

        ok $percent == $expected.Int, $test-name;
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
        Example 1    |perl     |e|False| 25
        Example 2    |java     |a|False| 50
        Example 3    |python   |m|False|  0
        Example 4    |ada      |a|False| 67
        Example 5    |ballerina|l|False| 22
        Example 6    |analitik |k|False| 13
        Empty string |         |a|False|  0
        Same chars   |jjjjj    |j|False|100
        Ignore case 1|Aardvark |A|True | 38
        Ignore case 2|Aardvark |a|True | 38
        Use case 1   |Aardvark |A|False| 13
        Use case 2   |Aardvark |a|False| 25
        END
}

################################################################################
