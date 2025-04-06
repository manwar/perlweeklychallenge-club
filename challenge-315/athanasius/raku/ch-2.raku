use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 315
=========================

TASK #2
-------
*Find Third*

Submitted by: Mohammad Sajid Anwar

You are given a sentence and two words.

Write a script to return all words in the given sentence that appear in sequence
to the given two words.

Example 1

  Input: $sentence = "Perl is a my favourite language but Python is my favourite
                      too."
         $first = "my"
         $second = "favourite"
  Output: ("language", "too")

Example 2

  Input: $sentence = "Barbie is a beautiful doll also also a beautiful 
                      princess."
         $first = "a"
         $second = "beautiful"
  Output: ("doll", "princess")

Example 3

  Input: $sentence = "we will we will rock you rock you.",
         $first = "we"
         $second = "will"
  Output: ("we", "rock")

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
2. A sentence is entered on the command-line, followed by two words.

Assumptions
-----------
1. Matches are case-sensitive, except in the following case: if the first match
   word begins with a lowercase letter, it matches the same word beginning with
   an uppercase letter if that word appears at the start of the sentence.
2. Punctuation characters are removed from the beginnings and endings of words,
   but not from within words. So, hyphenated words and possessives ending in
   "'s" remain unchanged.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 315, Task #2: Find Third (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $sentence,                       #= A sentence
    Str:D $first,                          #= First  word
    Str:D $second                          #= Second word
)
#===============================================================================
{
    qq[Input:  \$sentence = "$sentence"].put;
    qq[        \$first    = "$first"]\  .put;
    qq[        \$second   = "$second"]\ .put;

    my Str @third-words = find-third-words( $sentence, $first, $second );

    "Output: (%s)\n".printf: @third-words.map( { qq["$_"] } ).join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-third-words
(
    Str:D $sentence,
    Str:D $first,
    Str:D $second
--> List:D[Str:D]
)
#-------------------------------------------------------------------------------
{
    # Split the sentence into words, but discard any "words" comprising only
    # punctuation, e.g. "--" or "***"

    my Str @words = $sentence.split( / \s+ / ).grep: { / <alnum> / };

    for @words   # Remove punctuation but leave internal hyphens and apostrophes
    {
        s/ \" //;                   # Remove all double quotes
        s/ \' (\S+) /$0/;           # Remove initial single quotes
        s/ <punct>+ $ //;           # Remove all trailing punctuation
    }

    # Allow for a capital letter at the beginning of the sentence

    @words[ 0 ] ~~ s/ ^ (.) /{ $0.lc }/ if @words.elems > 0 &&
                                           $first ~~ / ^ <lower> /;
    my Str @third-words;

    for 0 .. @words.end - 2 -> UInt $i
    {
        @third-words.push: @words[ $i + 2 ] if @words[ $i     ] eq $first &&
                                               @words[ $i + 1 ] eq $second;
    }

    return @third-words;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $sentence, $first, $second, $expected-str) =
                $line.split: / \| /;

        for     $test-name, $sentence, $first, $second, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str @third-words = find-third-words( $sentence, $first, $second );
        my Str @expected    = $expected-str.split: / \s+ /, :skip-empty;

        is-deeply @third-words, @expected, $test-name;
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
        Example 1 |Perl is a my favourite language but Python is my favourite  \
                   too.|my|favourite|language too
        Example 2 |Barbie is a beautiful doll also also a beautiful princess   \
                  |a|beautiful|doll princess
        Example 3 |we will we will rock you rock you.|we|will|we rock
        Case 1    |We will we will rock you rock you.|we|will|we rock
        Case 2    |Computers are fun, but computers are also a lot of work!    \
                  |computers|are|fun also
        Hyphenated|My friend is hard-working, but your friend is lazy.         \
                  |friend|is|hard-working lazy
        END

    return S:g/ \\ \n \s* // given $data;
}

################################################################################
