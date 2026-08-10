use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 385
=========================

TASK #1
-------
*Uncommon Words*

Submitted by: Mohammad Sajid Anwar

You are given two sentences.

Write a script to return list of all uncommon words, order is not important.

Example 1

  Input: $sentence1 = "apple banana apple"
         $sentence2 = "banana orange"
  Output: ("orange")

Example 2

  Input: $sentence1 = "cat dog"
         $sentence2 = "bird fish"
  Output: ("cat", "dog", "bird", "fish")

Example 3

  Input: $sentence1 = "the quick brown fox"
         $sentence2 = "the quick"
  Output: ("brown", "fox")

Example 4

  Input: $sentence1 = "hello"
         $sentence2 = "hello"
  Output: ()

Example 5

  Input: $sentence1 = "blue blue red"
         $sentence2 = "red green green yellow"
  Output: ("yellow")

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
2. Two sentences are entered on the command-line.

Assumption
----------
Comparisons are case-sensitive.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 385, Task #1: Uncommon Words (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $sentence1,                    #= First  sentence
    Str:D $sentence2                     #= Second sentence
)
#===============================================================================
{
    qq[Input:  \$sentence1 = "$sentence1"].put;
    qq[        \$sentence2 = "$sentence2"].put;

    my Str @uncommon-words = find-uncommon-words( $sentence1, $sentence2 );

    "Output: (%s)\n".printf: @uncommon-words.map( { qq["$_"] } ).join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-uncommon-words( Str:D $sentence1, Str:D $sentence2 --> List:D[Str:D] )
#-------------------------------------------------------------------------------
{
    my Str  @words = $sentence1.split: / \s+ /, :skip-empty;
       push @words, |$sentence2.split: / \s+ /, :skip-empty;
    my UInt %word-count{Str};

          ++%word-count{ $_ } for @words;

    return  %word-count.keys.grep( { %word-count{ $_ } == 1 } ).sort.list;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $sentence1, $sentence2,  @expected) =
                $line.split: '|';

        for     $test-name, $sentence1, $sentence2, |@expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str @uncommon-words = find-uncommon-words( $sentence1, $sentence2 );

        is-deeply @uncommon-words, @expected, $test-name;
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
        Example 1|apple banana apple |banana orange         |orange
        Example 2|cat dog            |bird fish             |bird |cat|dog|fish
        Example 3|the quick brown fox|the quick             |brown|fox
        Example 4|hello              |hello
        Example 5|blue blue red      |red green green yellow|yellow
        END
}

################################################################################
