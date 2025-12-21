use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 352
=========================

TASK #1
-------
*Match String*

Submitted by: Mohammad Sajid Anwar

You are given an array of strings.

Write a script to return all strings that are a substring of another word in the
given array in the order they occur.

Example 1

  Input: @words = ("cat", "cats", "dog", "dogcat", "dogcat", "rat",
                   "ratcatdogcat")
  Output: ("cat", "dog", "dogcat", "rat")

Example 2

  Input: @words = ("hello", "hell", "world", "wor", "ellow", "elloworld")
  Output: ("hell", "world", "wor", "ellow")

Example 3

  Input: @words = ("a", "aa", "aaa", "aaaa")
  Output: ("a", "aa", "aaa")

Example 4

  Input: @words = ("flower", "flow", "flight", "fl", "fli", "ig", "ght")
  Output: ("flow", "fl", "fli", "ig", "ght")

Example 5

  Input: @words = ("car", "carpet", "carpenter", "pet", "enter", "pen", "pent")
  Output: ("car", "pet", "enter", "pen", "pent")

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. "Substring" means "proper substring".
2. The output does not contain duplicates.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of strings is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 352, Task #1: Match String (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@words                        #= A list of strings
)
#===============================================================================
{
    "Input:  \@words = (%s)\n".printf: @words.map( { qq["$_"] } ).join: ', ';

    my Str @matches = find-matches( @words );

    "Output: (%s)\n".printf:         @matches.map( { qq["$_"] } ).join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-matches( List:D[Str:D] $words --> List:D[Str:D] )
#-------------------------------------------------------------------------------
{
    my Str @matches;

    for 0 .. $words.end -> UInt $i
    {
        my Str $word1 = $words[$i];

        if $word1 eq @matches.none
        {
            for 0 .. $words.end -> UInt $j
            {
                next if $i == $j;

                my $word2 = $words[$j];

                if $word1 ne $word2 && $word2 ~~ / $word1 /
                {
                    @matches.push: $word1;
                    last;
                }
            }
        }
    }

    return @matches;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $words-str, $exptd-str) = $line.split: / \| /;

        for     $test-name, $words-str, $exptd-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str @words    = $words-str.split: / \s+ /, :skip-empty;
        my Str @matches  = find-matches( @words );
        my Str @expected = $exptd-str.split: / \s+ /, :skip-empty;

        is-deeply @matches, @expected, $test-name;
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
        Example 1|cat cats dog dogcat dogcat rat ratcatdogcat|cat dog dogcat rat
        Example 2|hello hell world wor ellow elloworld|hell world wor ellow
        Example 3|a aa aaa aaaa|a aa aaa
        Example 4|flower flow flight fl fli ig ght|flow fl fli ig ght
        Example 5|car carpet carpenter pet enter pen pent|car pet enter pen pent
        END
}

################################################################################
