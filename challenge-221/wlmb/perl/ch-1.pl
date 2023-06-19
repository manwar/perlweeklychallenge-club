#!/usr/bin/env perl
# Perl weekly challenge 221
# Task 1:  Good Strings
#
# See https://wlmb.github.io/2023/06/12/PWC221/#task-1-good-strings
use v5.36;
use List::Util qw(all);
die <<~"FIN" unless @ARGV;
    Usage: $0 C W1 [W2...]
    to find the total length of the set of words {Wn} than are formed by
    the characters in C
    FIN
my ($chars, @words)=@ARGV;
my %char_count;
$char_count{$_}++ for split "", $chars;
my @results=grep {
    my %word_char_count;
    $word_char_count{$_}++ for split "", $_;
    all {$word_char_count{$_}<=$char_count {$_}} keys %word_char_count
} @words;
say("chars: $chars, words: @words -> good strings: @results -> length: ",
    length join "", @results)
