#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

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

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 <paragraph>
  perl $0

    <paragraph>    A non-empty paragraph of text\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 181, Task #1: Sentence Order (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        run_tests();
    }
    elsif ($args == 1)
    {
        my $paragraph = $ARGV[ 0 ];

        printf "Input:\n    %s\n\n", $paragraph;
        printf "Output:\n    %s\n",  join ' ', order_paragraph( $paragraph );
    }
    else
    {
        die "ERROR: Expected 0 or 1 command line arguments, found $args\n" .
             $USAGE;
    }
}

#------------------------------------------------------------------------------
sub order_paragraph
#------------------------------------------------------------------------------
{
    my ($paragraph) = @_;
    my  @sentences;

    while ($paragraph =~ / (.+? (?: [.!?] | $)) (?: \s+ | $) /gx)
    {
        my $sentence = $1;
        my $terminal = $sentence =~ / [.!?] $ /x ? chop $sentence : '';
        my @words    = split /\s+/, $sentence;
           @words    = sort { lc $a cmp lc $b || $a cmp $b } @words;

        push @sentences, join( ' ', @words ) . $terminal;
    }

    return join ' ', @sentences;
}

#------------------------------------------------------------------------------
sub run_tests
#------------------------------------------------------------------------------
{
    for my $test (get_tests())
    {
        my $input    = $test->{ input }    =~ s/ (\n) //grx;
        my $expected = $test->{ expected } =~ s/ (\n) //grx;

        is order_paragraph( $input ), $expected, $test->{ name };
    }

    done_testing;
}

#------------------------------------------------------------------------------
sub get_tests
#------------------------------------------------------------------------------
{
    return
    (
        {
            name     => 'Example',
            input    =><<~INPUT,
                All he could think about was how it would all end. There was 
                still a bit of uncertainty in the equation, but the basics 
                were there for anyone to see. No matter how much he tried to 
                see the positive, it wasn't anywhere to be seen. The end was 
                coming and it wasn't going to be pretty.
                INPUT
            expected =><<~EXPECTED,
                about All all could end he how it think was would. a anyone 
                basics bit but equation, for in of see still the the There 
                there to uncertainty was were. anywhere be he how it matter 
                much No positive, see seen the to to tried wasn't. and be 
                coming end going it pretty The to was wasn't.
                EXPECTED
        },
        {
            name     => 'Quick brown fox',
            input    =><<~INPUT,
                The quick brown fox jumped over the lazy dog? No! The quick 
                brown fox jumped over the unfortunate dog.
                INPUT
            expected =><<~EXPECTED,
                brown dog fox jumped lazy over quick The the? No! brown dog 
                fox jumped over quick The the unfortunate.
                EXPECTED
        },
        {
            name     => 'Conversation',
            input    =><<~INPUT,
                Hello, how are you? I'm fine. Hope you are too! Do you think 
                it'll rain today? I hope not!
                INPUT
            expected =><<~EXPECTED,
                are Hello, how you? fine I'm. are Hope too you! Do it'll 
                rain think today you? hope I not!
                EXPECTED
        },
        {
            name     => 'Woodchuck',
            input    =><<~INPUT,
                How many chucks would a woodchuck chuck if a woodchuck could 
                Chuck wood? A woodchuck would chuck all that he could if a 
                woodchuck could cHuck wood!
                INPUT
            expected =><<~EXPECTED,
                a a Chuck chuck chucks could How if many wood woodchuck 
                woodchuck would? A a all cHuck chuck could could he if that 
                wood woodchuck woodchuck would!
                EXPECTED
        },
        {
            name     => '5th day of Christmas',
            input    =><<~INPUT,
                On the 5th day of Christmas, my true love sent to me: 5 golden 
                rings, 4 calling birds, 3 French hens, 2 turtle doves, and a 
                partridge in a pear tree.
                INPUT
            expected =><<~EXPECTED,
                2 3 4 5 5th a a and birds, calling Christmas, day doves, 
                French golden hens, in love me: my of On partridge pear rings, 
                sent the to tree true turtle.
                EXPECTED
        },
    );
}

###############################################################################
