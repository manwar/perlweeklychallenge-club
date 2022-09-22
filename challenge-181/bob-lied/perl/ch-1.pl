#!/bin/env perl
#
# Task 1: Sentence Order
# 
# You are given a paragraph. Write a script to order each sentence
# alphanumerically and print the whole paragraph.
# Example
# 
# Input:
#     All he could think about was how it would all end. There was
#     still a bit of uncertainty in the equation, but the basics
#     were there for anyone to see. No matter how much he tried to
#     see the positive, it wasn't anywhere to be seen. The end was
#     coming and it wasn't going to be pretty.
# 
# Ouput:
#     about All all could end he how it think was would. a anyone
#     basics bit but equation, for in of see still the the There
#     there to uncertainty was were. anywhere be he how it matter
#     much No positive, see seen the to to tried wasn't. and be
#     coming end going it pretty The to was wasn't.

use v5.30;
use strict;
use warnings;

use List::Util qw(maxstr);
use Text::Wrap;

my @inputParagraph = <>; # slurp

# We want to format the output to the same width as the input
# so find the longest line.
my $maxLineLength = maxstr(map length, @inputParagraph);

# Split sentences. For simplicity, assume a period (or question mark
# or exclamation point) followed by white space is the end of a sentence.
# This can be fooled by abbrevations, of course, but we aren't going
# into the rabbit hole of parsing English. See Text::Sentence or
# Lingua::EN::Sentence for better.
my @sentenceCollection = split(/[.?!]\s+/, join(" ", @inputParagraph) );

my @output;
for my $sentence ( @sentenceCollection )
{
    # Split words on white space
    my @wordCollection = split(/\s+/, $sentence );

    # End each "sentence" with a period.
    push @output, join(" ", sort { lc($a) cmp lc($b) } @wordCollection) . ".";
}

# Text::Wrap is core perl
$Text::Wrap::columns = $maxLineLength;
say Text::Wrap::wrap('', '', join(" ", @output) );
