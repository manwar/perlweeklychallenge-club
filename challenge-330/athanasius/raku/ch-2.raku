use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 330
=========================

TASK #2
-------
*Title Capital*

Submitted by: Mohammad Sajid Anwar

You are given a string made up of one or more words separated by a single space.

Write a script to capitalise the given title. If the word length is 1 or 2 then
convert the word to lowercase otherwise make the first character uppercase and
remaining lowercase.

Example 1

  Input: $str = "PERL IS gREAT"
  Output: "Perl is Great"

Example 2

  Input: $str = "THE weekly challenge"
  Output: "The Weekly Challenge"

Example 3

  Input: $str = "YoU ARE A stAR"
  Output: "You Are a Star"

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
2. A string made up of one or more words separated by single spaces is entered
   on the command-line.

Assumption
----------
The first word of the title should be title-cased, even if it is only 1 or 2
characters long.

=end comment
#===============================================================================

use Test;

my regex input-re { ^ <[ A..Z a..z ]>+ [ ' ' <[ A..Z a..z ]>+ ]* $ }

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 330, Task #2: Title Capital (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A string made up of one or more words separated by single spaces

    Str:D $str where m[ <input-re> ]
)
#===============================================================================
{
    qq[Input: \$str = "$str"].put;

    my Str $title = capitalise( $str );

    qq[Output:       "$title"].put:
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub capitalise( Str:D $str where m[ <input-re> ] --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str @words = $str.split: ' ';
    my Str @title = @words.shift.tclc;

    for @words -> Str $word
    {
        @title.push: $word.chars > 2 ?? $word.tclc !! $word.lc;
    }

    return @title.join: ' ';
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

        my Str $title = capitalise( $str );

        is $title, $expected, $test-name;
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
        Example 1 |PERL IS gREAT       |Perl is Great
        Example 2 |THE weekly challenge|The Weekly Challenge
        Example 3 |YoU ARE A stAR      |You Are a Star
        First word|a star is born      |A Star is Born
        END
}

################################################################################
