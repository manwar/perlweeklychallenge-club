use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 353
=========================

TASK #1
-------
*Max Words*

Submitted by: Mohammad Sajid Anwar

You are given an array of sentences.

Write a script to return the maximum number of words that appear in a single
sentence.

Example 1

  Input: @sentences = ("Hello world", "This is a test", "Perl is great")
  Output: 4

Example 2

  Input: @sentences = ("Single")
  Output: 1

Example 3

  Input: @sentences = ("Short", "This sentence has seven words in total",
                       "A B C", "Just four words here")
  Output: 7

Example 4

  Input: @sentences = ("One", "Two parts", "Three part phrase", "")
  Output: 3

Example 5

  Input: @sentences = ("The quick brown fox jumps over the lazy dog", "A",
                       "She sells seashells by the seashore",
                       "To be or not to be that is the question")
  Output: 10

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. Punctuation characters may, in general, be ignored, since they are counted as
   part of their adjacent words.
2. Apostrophes of possession may be similarly ignored since an expression like
   "Robert's book" is counted as 2 words.
3. The exceptions are dashes, which are not counted as words. They are handled
   as follows:
     i. Two or more hyphens together are considered a dash, whether or not they
        are surrounded by whitespace: "The problem--difficult though it may
        be--must be addressed" is counted as 10 words.
    ii. A single, detached hyphen is considered a dash: "Perl is useful - and
        fun!" is counted as 5 words.
   iii. All other hyphens are ignored. (This will sometimes produce incorrect
        results, since a compound phrase like "even-handed" should probably be
        counted as 2 words. However, distinguishing between "co-operate" [1
        word] and "heavy-metal" [2 words] would require recourse to a diction-
        ary, which is beyond the scope of this exercise.)

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of sentences is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 353, Task #1: Max Words (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@sentences                     #= A list of sentences
)
#===============================================================================
{
    "Input:  \@sentences = (%s)\n".printf: @sentences.map( { qq["$_"] } )
                                                     .join: ', ';

    my UInt $max-words = count-max-words( Array[Str].new: @sentences );

    "Output: $max-words".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-max-words( List:D[Str:D] $sentences --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $max-words = 0;

    for @$sentences <-> Str $sentence
    {
        given $sentence                     # Handle dashes
        {
            s:g/     \- \-+     / /;
            s:g/ \s+ \-     \s+ / /;
        }

        my Str @words =  $sentence.split: / \s+ /, :skip-empty;
        $max-words    = ($max-words, @words.elems).max;
    }

    return $max-words;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $expected, @sentences) = $line.split: / \| /;

        for     $test-name, $expected, |@sentences
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt $max-words = count-max-words( @sentences );

        is $max-words, $expected.Int, $test-name;
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
    my Str $data = q:to/END/;
        Example 1  | 4|Hello world|This is a test|Perl is great
        Example 2  | 1|Single
        Example 3  | 7|Short|This sentence has seven words in total|A B C      \
                      |Just four words here
        Example 4  | 3|One|Two parts|Three part phrase|
        Example 5  |10|The quick brown fox jumps over the lazy dog|A           \
                      |She sells seashells by the seashore                     \
                      |To be or not to be that is the question
        Dashes     |10|To be - or not to be--that is the question
        Punctuation|10|To be, or not to be: is that the question?
        END

    return S:g/ \s* \\ \n \s* // given $data;
}

################################################################################
