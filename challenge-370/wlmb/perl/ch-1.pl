#!/usr/bin/env perl
# Perl weekly challenge 370
# Task 1:  Popular Word
#
# See https://wlmb.github.io/2026/04/20/PWC370/#task-1-popular-word
use v5.36;
use List::UtilsBy qw(max_by);
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 P0 B0 P1 B1...
    where Pn is a paragraph and Bn is a space separated list
    if banned words, to find the most frequent permitted word
    of each paragraph.
    FIN
for my($paragraph, $banned)(@ARGV){
    my %banned;
    my %words;
    ++$banned{$_} for split " ", $banned;
    ++$words{$_} for
        grep {!$banned{$_}}
        split/[^a-z]+/,
        lc $paragraph;
    print <<~"END";
        Paragraph="$paragraph";
        banned="$banned"
        END
    say "    -> ", max_by{$words{$_}} keys %words;
}
