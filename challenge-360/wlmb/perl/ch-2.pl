#!/usr/bin/env perl
# Perl weekly challenge 360
# Task 2:  Word Sorter
#
# See https://wlmb.github.io/2026/02/08/PWC360/#task-2-word-sorter
use v5.36;
use List::UtilsBy qw(sort_by);
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to sort the words of sentence Sn
    FIN
for(@ARGV){
    my @words=split " ";
    say "$_ -> ", join " ", sort_by{lc}@words;
}
