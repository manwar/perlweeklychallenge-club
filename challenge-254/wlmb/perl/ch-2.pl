#!/usr/bin/env perl
# Perl weekly challenge 254
# Task 2:  Reverse Vowels
#
# See https://wlmb.github.io/2024/01/29/PWC254/#task-2-reverse-vowels
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 W1 [W2..]
    to reverse the vowels in the words W1 W2...
    FIN
for(@ARGV){
    my @all = split "", lc $_;
    my @vowel_indices=grep {$all[$_]=~/[aeiou]/} 0..@all-1;
    @all[@vowel_indices]=reverse @all[@vowel_indices];
    my $out=ucfirst join "", @all;
    say "$_ -> $out";
}
