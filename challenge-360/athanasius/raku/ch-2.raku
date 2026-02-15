use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 360
=========================

TASK #2
-------
*Word Sorter*

Submitted by: Mohammad Sajid Anwar

You are give a sentence.

Write a script to order words in the given sentence alphabetically but keeps the
words themselves unchanged.

Example 1

  Input: $str = "The quick brown fox"
  Output: "brown fox quick The"

Example 2

  Input: $str = "Hello    World!   How   are you?"
  Output: "are Hello How World! you?"

Example 3

  Input: $str = "Hello"
  Output: "Hello"

Example 4

  Input: $str = "Hello, World! How are you?"
  Output: "are Hello, How World! you?"

Example 5

  Input: $str = "I have 2 apples and 3 bananas!"
  Output: "2 3 and apples bananas! have I"

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. Sorting is ASCII-betical (digits before letters, see Example 5), but *case-
   insensitive*.
2. If two words differ only in the case of their letters, then their relative
   positions in the original sentence are retained in the output.
3. A punctuation character is, in general, treated as part of the word to which
   it is joined.
4. The exception is the dash, which is identified as either:
   - two or more contiguous hyphen-minus characters; or
   - a single hyphen-minus character surrounded on both sides by whitespace.
   Dashes are discarded, as they do not constitute "words".

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A sentence is entered on the command-line as a single string.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 360, Task #2: Word Sorter (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str                          #= A sentence
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my Str $ordered-str = sort-words( $str );

    qq[Output: "$ordered-str"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub sort-words( Str:D $str --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str $sentence =  S:g/ \- \-    / / with $str;
           $sentence ~~ s:g/ \s \- \s / /;

    my Str @words = $sentence.split: / \s+ /, :skip-empty;

    return @words.sort( *.lc ).join: ' ';
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

        my Str $ordered-str = sort-words( $str );

        is $ordered-str, $expected, $test-name;
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
       Example 1|The quick brown fox             |brown fox quick The
       Example 2|Hello    World!   How   are you?|are Hello How World! you?
       Example 3|Hello                           |Hello
       Example 4|Hello, World! How are you?      |are Hello, How World! you?
       Example 5|I have 2 apples and 3 bananas!  |2 3 and apples bananas! have I
       Dashes   |Hello - how are you--fine?      |are fine? Hello how you
       END
}

################################################################################
