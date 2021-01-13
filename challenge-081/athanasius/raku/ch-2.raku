use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 081
=========================

Task #2
-------
*Frequency Sort*

Submitted by: Mohammad S Anwar

You are given file named input.

Write a script to find the frequency of all the words.

It should print the result as first column of each line should be the frequency
of the the word followed by all the words of that frequency arranged in lexico-
graphical order. Also sort the words in the ascending order of frequency.

INPUT file

 West Side Story

 The award-winning adaptation of the classic romantic tragedy "Romeo and
 Juliet". The feuding families become two warring New York City gangs, the
 white Jets led by Riff and the Latino Sharks, led by Bernardo. Their hatred
 escalates to a point where neither can coexist with any form of understanding.
 But when Riff's best friend (and former Jet) Tony and Bernardo's younger
 sister Maria meet at a dance, no one can do anything to stop their love. Maria
 and Tony begin meeting in secret, planning to run away. Then the Sharks and
 Jets plan a rumble under the highway--whoever wins gains control of the
 streets. Maria sends Tony to stop it, hoping it can end the violence. It goes
 terribly wrong, and before the lovers know what's happened, tragedy strikes
 and doesn't stop until the climactic and heartbreaking ending.

NOTE

For the sake of this task, please ignore the following in the input file:

 . " ( ) , 's --

OUTPUT

 1 But City It Jet Juliet Latino New Romeo Side Story Their Then West York
 adaptation any anything at award-winning away become before begin best classic
 climactic coexist control dance do doesn't end ending escalates families
 feuding form former friend gains gangs goes happened hatred heartbreaking
 highway hoping in know love lovers meet meeting neither no one plan planning
 point romantic rumble run secret sends sister streets strikes terribly their
 two under understanding until violence warring what when where white whoever
 wins with wrong younger

 2 Bernardo Jets Riff Sharks The by it led tragedy

 3 Maria Tony a can of stop

 4 to

 9 and the

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

my constant $DEFAULT-INPUT-FILE = 'WestSideStory.txt';

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 081, Task #2: Frequency Sort (Raku)".put;
}

##=============================================================================
sub MAIN
(
    Str:D $input where *.IO.f = $DEFAULT-INPUT-FILE          #= Input file name
)
##=============================================================================
{
    # (1) Read in and edit the input text

    my Str $text = $input.IO.slurp;

    # The text is first edited by replacing trailing 's and _ with spaces, then
    # any remaining apostrophes are converted to underscores. This is done
    # because \w matches the underscore character but not the apostrophe: which
    # makes it easy to identify "words" using the zero-width assertions « and »
    # that match on word boundaries (\W\w and \w\W). Note: It is not necessary
    # to remove the other non-word characters [."(),] from the text, as these
    # are automatically excluded by the match logic of the regex below.

    $text ~~ s:g/ \'s » / /;
    $text ~~ s:g/  _    / /;
    $text ~~ s:g/ \'    /_/;

    # (2) Create a dictionary of words (keys) and their frequencies (values)

    my UInt %by-word;

    for $text ~~ m:g/ « (\w+?) » / -> Match $match
    {
        my Str $word =  $match.Str;

        # Once a word has been identified, its apostrophes (if any) are
        # restored, then it is recorded in the dictionary

        $word ~~ s:g/ _ /'/;

        ++%by-word{ $word };
    }

    # (3) Create a reverse dictionary of frequencies (keys) and arrays of words
    #     (values)

    my Array[Str] %by-freq;

    for %by-word.kv -> Str $word, UInt $freq
    {
        %by-freq{ $freq }.push: $word;
    }

    # (4) Output frequencies (in ascending numerical order) together with their
    #     associated words (in ascending lexicographical order)

    for %by-freq.keys.map( { .UInt }).sort -> UInt $freq
    {
        "\n%d %s\n".printf: $freq, %by-freq{ $freq }.sort.join: ' ';
    }
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

###############################################################################
