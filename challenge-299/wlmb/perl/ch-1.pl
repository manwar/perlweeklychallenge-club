#!/usr/bin/env perl
# Perl weekly challenge 299
# Task 1:  Replace Words
#
# See https://wlmb.github.io/2024/12/09/PWC299/#task-1-replace-words
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S W1 W2...
    to replace all words in the sentence S that start with word Wi by Wi
    FIN
my $sentence=shift;
my @words=@ARGV;
my $alternation=join "|",@words;
say "Sentence: $sentence\nwords: @words\n -> ", $sentence=~s/($alternation)\w*/$1/gr, "\n";
