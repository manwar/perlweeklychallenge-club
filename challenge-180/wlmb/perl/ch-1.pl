#!/usr/bin/env perl
# Perl weekly challenge 180
# Task 1: First unique character
#
# See https://wlmb.github.io/2022/08/29/PWC180/#task-1-first-unique-character
use v5.36;
use List::MoreUtils qw(firstidx);
say "Usage: $0 S1 [S2...]\n to find the first unique character of strings S1, S2...\n"
    unless @ARGV;
foreach(@ARGV){
    my @chars=split ""; # or split "", lc or grep {/\S/} split...
    my %count;
    $count{$_}++ foreach(@chars);
    my $first= firstidx {$count{$_}==1} @chars;
    say "The first unique character of '$_' is $first->$chars[$first]" if $first>=0;
    say "'$_' has no unique characters" if $first==-1;
}
