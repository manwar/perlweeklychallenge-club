use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 266
=========================

TASK #1
-------
*Uncommon Words*

Submitted by: Mohammad Sajid Anwar

You are given two sentences, $line1 and $line2.

Write a script to find all uncommmon words in any order in the given two sen-
tences. Return ('') if none found.

    A word is uncommon if it appears exactly once in one of the sentences and
    doesn't appear in other sentence.

Example 1

  Input: $line1 = 'Mango is sweet'
         $line2 = 'Mango is sour'
  Output: ('sweet', 'sour')

Example 2

  Input: $line1 = 'Mango Mango'
         $line2 = 'Orange'
  Output: ('Orange')

Example 3

  Input: $line1 = 'Mango is Mango'
         $line2 = 'Orange is Orange'
  Output: ('')

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. Word-matching within and between sentences is case-insensitive.
2. Singular and plural forms are treated as distinct words.
3. Two or more hyphens together are treated as a word-separating dash.
4. A single hyphen is assumed to be "hard" and is retained within a word.
5. The possessive forms ending in "'s" or "'" are ignored when matching words.
6. Other punctuation symbols (commas, full stops, colons, semicolons, question
   marks, exclamation marks, single quotes, and double quotes) are treated as
   word-separators but otherwise ignored.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The input sentences are entered as two strings on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 266, Task #1: Uncommon Words (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $line1,                    #= The first  sentence
    Str:D $line2                     #= The second sentence
)
#===============================================================================
{
    "Input:  \$line1 = '$line1'".put;
    "        \$line2 = '$line2'".put;

    my Str @uncommon-words = find-uncommon-words( $line1, $line2 );

    "Output: (%s)\n".printf: @uncommon-words.elems == 0 ?? "''" !!
                             @uncommon-words.map( { "'$_'" } ).join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-uncommon-words( Str:D $line1, Str:D $line2 --> List:D[Str:D] )
#-------------------------------------------------------------------------------
{
    my Str @words      = filter-words( $line1 );
           @words.push: |filter-words( $line2 );

    my UInt %dict;
          ++%dict{ $_ } for @words.map: { .lc };

    my Str @uncommon;

    for @words -> Str $word
    {
        @uncommon.push: $word if %dict{ $word.lc } == 1;
    }

    return @uncommon;
}

#-------------------------------------------------------------------------------
sub filter-words( Str:D $line --> List:D[Str:D] )
#-------------------------------------------------------------------------------
{
    my Str $l = $line;                           # Make a local copy

    $l ~~ s:g/ \- ** 2..*         / /;           # Convert dashes to spaces
    $l ~~ s:g/ <?after \w > \' s? //;            # Remove possessive markers
    $l ~~ s:g/ <[.,;:!?'"]>       / /;           # Convert punctuation to spaces

    my Str @words = $l.split: / \s+ /, :skip-empty;     # Find (non-empty) words

    return @words;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $line1, $line2, $expected-str) =
                $line.split: / \| /;

        for     $test-name, $line1, $line2, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str @uncommon-words = find-uncommon-words( $line1, $line2 );
        my Str @expected-words = $expected-str.split: / \s+ /, :skip-empty;

        is-deeply @uncommon-words, @expected-words, $test-name;
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
        Example 1  |Mango is sweet       |Mango is sour        |sweet sour
        Example 2  |Mango Mango          |Orange               |Orange
        Example 3  |Mango is Mango       |Orange is Orange     |
        Case       |The cat is on the mat|A dog is on a log    |cat mat dog log
        Plurals    |This dog likes dogs  |This dog likes cats  |dogs cats
        Possessives|Pete is my son's son |Pete is my grandson  |grandson
        Dash       |Sue--my favourite.   |Is Sue my favourite? |Is
        Hyphen     |Implement: egg-beater|Egg implement        |egg-beater Egg
        Punctuation|Sue has a book.      |Does Sue have a book?|has Does have
        Quotes     |"Mango" is sweet     |Mango is 'sour'      |sweet sour
        END
}

################################################################################
