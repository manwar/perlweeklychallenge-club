#!/usr/bin/env perl

# Challenge 216
#
# Task 2: Word Stickers
# Submitted by: Mohammad S Anwar
#
# You are given a list of word stickers and a target word.
#
# Write a script to find out how many word stickers is needed to make up the
# given target word.
#
# Example 1:
#
# Input: @stickers = ('perl','raku','python'), $word = 'peon'
# Output: 2
#
# We just need 2 stickers i.e. 'perl' and 'python'.
# 'pe' from 'perl' and
# 'on' from 'python' to get the target word.
#
# Example 2:
#
# Input: @stickers = ('love','hate','angry'), $word = 'goat'
# Output: 3
#
# We need 3 stickers i.e. 'angry', 'love' and 'hate'.
# 'g' from 'angry'
# 'o' from 'love' and
# 'at' from 'hate' to get the target word.
#
# Example 3:
#
# Input: @stickers = ('come','nation','delta'), $word = 'accommodation'
# Output: 4
#
# We just need 2 stickers of 'come' and one each of 'nation' & 'delta'.
# 'a' from 'delta'
# 'ccommo' from 2 stickers 'come'
# 'd' from the same sticker 'delta' and
# 'ation' from 'nation' to get the target word.
#
# Example 4:
#
# Input: @stickers = ('come','country','delta'), $word = 'accommodation'
# Output: 0
#
# as there's no "i" in the inputs.

use Modern::Perl;

sub max_match {
    my($word, @stickers) = @_;
    for my $len (reverse 1 .. length($word)) {
        for my $s (0 .. length($word)-$len) {
            my $match = substr($word, $s, $len);

            for my $i (0 .. $#stickers) {
                if ($stickers[$i] =~ /$match/) {
                    return ($match, $i);
                }
            }
        }
    }
    return ("", -1);
}

sub count_stickers {
    my($word, @stickers) = @_;
    @stickers = (@stickers) x length($word);
    my %used;
    while ($word ne '') {
        my($match, $sticker) = max_match($word, @stickers);
        return 0 if $match eq "";
        $used{$sticker} = 1;
        $word =~ s/$match//;
        $stickers[$sticker] =~ s/$match//;
    }
    return scalar keys %used;
}

say count_stickers(@ARGV);


