#!/usr/bin/env perl
# Perl weekly challenge 181
# Task 1: Sentence order
#
# See https://wlmb.github.io/2022/09/05/PWC181/#task-1-sentence-order
use v5.36;
use Text::Wrap qw(wrap $columns $break);
$columns=62; $break=qr/\s/;
local $/ = ""; # paragraph mode
while(<>){ # for each paragraph
    chomp; # remove trailing newlines
    my @output;
    foreach(split /\./){ # For each sentence. Assume ends in "."
	my @words = split " "; # Separate into words. Assume a space even after punctuation.
	my @sorted_words = sort {fc $a cmp fc $b} @words;
	push @output, join(" ",  @sorted_words) . ". "; # join words and add ending "."
    }
    say wrap('', '', (join " ", @output), "\n");
}
