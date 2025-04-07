#!/usr/bin/env perl
# Perl weekly challenge 316
# Task 1:  Circular
#
# See https://wlmb.github.io/2025/04/07/PWC316/#task-1-circular
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 W1 W2...W_N
    to find if the last letter of the word W{n} coincides with the
    first letter of the word W{n+1} for n=1...N-1.
    FIN
for(@ARGV){die "Expected single word: $_" unless /^\S+$/}
my @words=map{lc}@ARGV;     #normalize to lower case
my $all="@words";
my @matches=$all=~/(\w)\s\1/g;
my $results=(@matches==@words-1)?"True":"False";
say "@ARGV -> $results";
