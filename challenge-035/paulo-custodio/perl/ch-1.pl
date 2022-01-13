#!/usr/bin/perl

# Challenge 035
#
# TASK #1
# Contributed by Paul Johnson
# Write a program to encode text into binary encoded morse code.
# Pay attention to any changes which might need to be made to the text to
# make it valid morse code.
#
# Morse code consists of dots, dashes and gaps. It can be encoded in binary
# in the following fashion:
#
# dot: 1
# dash: 111
# intra-character gap: 0
# character gap: 000
# word gap: 0000000
# An intra-character gap is inserted between the dots and dashes in a character.

use Modern::Perl;
use Text::Morse;

sub encode_bin_morse {
    my($text) = @_;
    my $morse = Text::Morse->new;
    my $encoded = $morse->Encode($text);    # ' ' between chars, '\n' between words
    for ($encoded) {
        s/\./10/g;              # . = 1 + 0 gap
        s/\-/1110/g;            # - = 111 + 0 gap
        s/ /00/g;               # inter-word = 000 - 0 gap
        s/\n/0000/g;            # word gap = 0000000 - 00 - 0
        s/0+$//                 # remove trailing zeros
    }
    return $encoded;
}

say encode_bin_morse("@ARGV");
