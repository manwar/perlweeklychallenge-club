use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 274
=========================

TASK #1
-------
*Goat Latin*

Submitted by: Mohammad Sajid Anwar

You are given a sentence, $sentance.

Write a script to convert the given sentence to Goat Latin, a made up language
similar to Pig Latin.

Rules for Goat Latin:

  1) If a word begins with a vowel ("a", "e", "i", "o", "u"), append
     "ma" to the end of the word.
  2) If a word begins with consonant i.e. not a vowel, remove first
     letter and append it to the end then add "ma".
  3) Add letter "a" to the end of first word in the sentence, "aa" to
     the second word, etc etc.

Example 1

  Input: $sentence = "I love Perl"
  Output: "Imaa ovelmaaa erlPmaaaa"

Example 2

  Input: $sentence = "Perl and Raku are friends"
  Output: "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa"

Example 3

  Input: $sentence = "The Weekly Challenge"
  Output: "heTmaa eeklyWmaaa hallengeCmaaaa"

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
Within a series of "word" (alphabetic) characters, a hyphen is taken to be a
separator of distinct words.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The input sentence is entered as an unnamed (positional) argument on the
   command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 274, Task #1: Goat Latin (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $sentence               #= A sentence to be translated into Goat Latin
)
#===============================================================================
{
    qq[Input:  \$sentence = "$sentence"].put;

    my Str $translation = translate( $sentence );

    qq[Output: "$translation"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub translate( Str:D $sentence --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str  $translation = '';
    my UInt $count       =  1;

    for $sentence.split: / <|w> /, :skip-empty -> Str $chunk     # Split on word
    {                                                            #   boundaries
        if $chunk ~~ / \w /       # (1) The chunk is a word that...
        {
            if $chunk ~~ m:i/ ^ <[aeiou]> /    # (1a) ...begins with a vowel
            {
                $translation ~= $chunk;
            }
            else                               # (1b) ...begins with a consonant
            {
                $translation ~= $chunk.substr( 1 ) ~ $chunk.substr( 0, 1 );
            }

            $translation ~= 'ma' ~ 'a' x $count++;       # Append goatish suffix
        }
        else                      # (2) The chunk is space(s) and/or punctuation
        {
            $translation ~= $chunk;
        }
    }

    return $translation;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $sentence, $expected) = $line.split: / \| /;

        for     $test-name, $sentence, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $translation = translate( $sentence );

        is $translation, $expected, $test-name;
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
    my Str $data = q:to/END/;
        Example 1|I love Perl              |Imaa ovelmaaa erlPmaaaa
        Example 2|Perl and Raku are friends|erlPmaa andmaaa akuRmaaaa aremaaaaa\
         riendsfmaaaaaa
        Example 3|The Weekly Challenge     |heTmaa eeklyWmaaa hallengeCmaaaa
        END

    $data ~~ s:g/ \\ \n //;                      # Concatenate backslashed lines

    return $data;
}

################################################################################
