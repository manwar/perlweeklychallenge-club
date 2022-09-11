use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 181
=========================

TASK #1
-------
*Sentence Order*

Submitted by: Mohammad S Anwar

You are given a paragraph.

Write a script to order each sentence alphanumerically and print the whole
paragraph.

Example

  Input:
      All he could think about was how it would all end. There was
      still a bit of uncertainty in the equation, but the basics
      were there for anyone to see. No matter how much he tried to
      see the positive, it wasn't anywhere to be seen. The end was
      coming and it wasn't going to be pretty.

  Output:
      about All all could end he how it think was would. a anyone
      basics bit but equation, for in of see still the the There
      there to uncertainty was were. anywhere be he how it matter
      much No positive, see seen the to to tried wasn't. and be
      coming end going it pretty The to was wasn't.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumptions
-----------
1. A *sentence* is a series of words ending in a full stop, a question mark, an
   exclamation mark, or the end of the paragraph.
2. Alphanumeric order places digits before letters, and upper case before lower
   case: e.g., aC1cB3b2A -> 123ABCabc.

Interface
---------
The paragraph to be reordered is entered on the command line. If no paragraph
is given, a test suite is run instead.

=end comment
#==============================================================================

use Test;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 181, Task #1: Sentence Order (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    Str:D $paragraph where { .chars > 0 }      #= A non-empty paragraph of text
)
#==============================================================================
{
    printf "Input:\n    %s\n\n", $paragraph;
    printf "Output:\n    %s\n",  order-paragraph( $paragraph ).join: ' ';
}

#==============================================================================
multi sub MAIN()
#==============================================================================
{
    run-tests;
}

#------------------------------------------------------------------------------
sub order-paragraph( Str:D $paragraph --> Str:D )
#------------------------------------------------------------------------------
{
    my Str @sentences;

    for $paragraph ~~ m:g/ <(.+? [ <[ . ! ? ]> || $ ])> [ \s+ || $ ] /
    {
        my Str $sentence = .Str;
        my Str $terminal = '';

        if $sentence ~~ / ^ (.+) (<[ . ! ? ]>) $ /
        {
            $sentence = ~$0;
            $terminal = ~$1;
        }

        my Str @words  = $sentence.split: /\s+/, :skip-empty;
               @words .= sort: { $^a.lc leg $^b.lc || $^a leg $^b };

        @sentences.push: @words.join( ' ' ) ~ $terminal;
    }

    return @sentences.join: ' ';
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    for get-tests() -> %test
    {
        my Str $input    = S:g/ (\n) // given %test< input    >;
        my Str $expected = S:g/ (\n) // given %test< expected >;

        is order-paragraph( $input ), $expected, %test< name >;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub get-tests( --> Array:D[Hash:D[Str:D]] )
#------------------------------------------------------------------------------
{
    return Array[Hash].new:
    {
        name     => 'Example',
        input    =>  q:to/INPUT/,
            All he could think about was how it would all end. There was still 
            a bit of uncertainty in the equation, but the basics were there 
            for anyone to see. No matter how much he tried to see the 
            positive, it wasn't anywhere to be seen. The end was coming and it 
            wasn't going to be pretty.
            INPUT
        expected =>  q:to/EXPECTED/,
            about All all could end he how it think was would. a anyone basics 
            bit but equation, for in of see still the the There there to 
            uncertainty was were. anywhere be he how it matter much No 
            positive, see seen the to to tried wasn't. and be coming end going 
            it pretty The to was wasn't.
            EXPECTED
    },
    {
        name     => 'Quick brown fox',
        input    =>  q:to/INPUT/,
            The quick brown fox jumped over the lazy dog? No! The quick brown 
            fox jumped over the unfortunate dog.
            INPUT
        expected =>  q:to/EXPECTED/,
            brown dog fox jumped lazy over quick The the? No! brown dog fox 
            jumped over quick The the unfortunate.
            EXPECTED
    },
    {
        name     => 'Conversation',
        input    =>  q:to/INPUT/,
            Hello, how are you? I'm fine. Hope you are too! Do you think it'll 
            rain today? I hope not!
            INPUT
        expected =>  q:to/EXPECTED/,
            are Hello, how you? fine I'm. are Hope too you! Do it'll rain 
            think today you? hope I not!
            EXPECTED
    },
    {
        name     => 'Woodchuck',
        input    =>  q:to/INPUT/,
            How many chucks would a woodchuck chuck if a woodchuck could Chuck 
            wood? A woodchuck would chuck all that he could if a woodchuck 
            could cHuck wood!
            INPUT
        expected =>  q:to/EXPECTED/,
            a a Chuck chuck chucks could How if many wood woodchuck woodchuck 
            would? A a all cHuck chuck could could he if that wood woodchuck 
            woodchuck would!
            EXPECTED
    },
    {
        name     => '5th day of Christmas',
        input    =>  q:to/INPUT/,
            On the 5th day of Christmas, my true love sent to me: 5 golden 
            rings, 4 calling birds, 3 French hens, 2 turtle doves, and a 
            partridge in a pear tree.
            INPUT
        expected =>  q:to/EXPECTED/,
            2 3 4 5 5th a a and birds, calling Christmas, day doves, French 
            golden hens, in love me: my of On partridge pear rings, sent the 
            to tree true turtle.
            EXPECTED
    },
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
