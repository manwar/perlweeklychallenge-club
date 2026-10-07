#!/usr/bin/env perl
# Perl weekly challenge 394
# Task 2:  Alternating Vowels Consonants
#
# See https://wlmb.github.io/2026/10/05/PWC394/#task-2-alternating-vowels-consonants
use v5.36;
use List::Util qw(max);
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to find the longest common substrings with alternating
    vowels and consonants of the three space separated words
    in string Sn
    FIN
my $vowels="aeiou";
for(@ARGV){
    my($x,$y,$z) = split " ";
    my $frags = fragments($x, fragments($y, [$z]));
    my $max = max map {length} @$frags;
    say "$_ -> ", join " ", grep {$max == length} @$frags;
}
sub fragments($word, $rest){
    my @frags;
    for my $start(0..length($word)-1){
        for my $length(1..length($word) - $start){
            my $frag = substr $word, $start, $length;
            next unless $frag=~/^[^$vowels]?([$vowels][^$vowels])*[$vowels]?$/;
            push @frags, $frag if grep {m/$frag/} @$rest;
        }
    }
    return [@frags];
}
