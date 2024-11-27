#!/usr/bin/env perl

# Challenge 181
#
# Task 1: Sentence Order
# Submitted by: Mohammad S Anwar
#
# You are given a paragraph.
#
# Write a script to order each sentence alphanumerically and print the whole
# paragraph.
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

use Modern::Perl;
use Text::Wrap;

sub read_input {
    local $/;
    my $text = <>;
    $text =~ s/\s+/ /g;
    return $text;
}

sub order_sentences {
    my($text) = @_;
    $text =~ s/\.\s*$//s;   # remove last period
    my @sentences = map {s/^\s+//; s/\s+$//; $_} split(/\./, $text);
    for (@sentences) {
        $_ = (join " ", sort {lc($a) cmp lc($b)} split " ", $_).".";
    }
    return join " ", @sentences;
}

sub reflow {
    my($text) = @_;
    local $Text::Wrap::columns = 60;
    return wrap("", "", $text);
}

print reflow(order_sentences(read_input()));
