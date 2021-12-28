#!/usr/bin/perl

# Challenge 035
#
# TASK #2
# Contributed by Paul Johnson
# Write a program to decode binary morse code.
# Consider how it might be possible to recover from badly formed morse code.
#
# a) by splitting the morse code on gaps
# b) without looking further than one digit ahead

use Modern::Perl;
use Text::Morse;

sub decode_bin_morse {
    my($encoded) = @_;
    for ($encoded) {
        s/0+$//;                # remove trailing zeros
        s/0000000/\n/g;         # word gap
        s/000/ /g;              # character gap
        s/1110?/-/g;            # -
        s/10?/./g;              # .
    }
    my $morse = Text::Morse->new;
    my $text = $morse->Decode($encoded);
    return $text;
}

say decode_bin_morse("@ARGV");
