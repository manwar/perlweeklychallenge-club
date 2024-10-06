#!/usr/bin/env perl

# Challenge 166
#
# Task 1: Hexadecimal Words
# Submitted by: Ryan J Thompson
#
# As an old systems programmer, whenever I needed to come up with a 32-bit
# number, I would reach for the tired old examples like 0xDeadBeef and
# 0xC0dedBad. I want more!
#
# Write a program that will read from a dictionary and find 2- to 8-letter
# words that can be "spelled" in hexadecimal, with the addition of the following
# letter substitutions:
#
#     o -> 0 (e.g., 0xf00d = "food")
#     l -> 1
#     i -> 1
#     s -> 5
#     t -> 7
#
# You can use your own dictionary or you can simply open
# ../../../data/dictionary.txt (relative to your script's location in our GitHub
# repository) to access the dictionary of common words from Week #161.
#
# Optional Extras (for an 0xAddedFee, of course!)
#
#     Limit the number of "special" letter substitutions in any one result to
#     keep that result at least somewhat comprehensible. (0x51105010 is an
#     actual example from my sample solution you may wish to avoid!)
#
#     Find phrases of words that total 8 characters in length
#     (e.g., 0xFee1Face), rather than just individual words.

use Modern::Perl;

@ARGV==1 or die "usage: ch-1.pl words.txt\n";
while (<>) {
    chomp;
    if (/^[a-f0list]{2,8}$/i) {
        my $word=$_;
        $word=~tr/olist/01157/;
        say "0x".uc($word);
    }
}
