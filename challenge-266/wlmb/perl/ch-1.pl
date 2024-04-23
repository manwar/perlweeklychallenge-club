#!/usr/bin/env perl
# Perl weekly challenge 266
# Task 1:  Uncommon Words
#
# See https://wlmb.github.io/2024/04/21/PWC266/#task-1-uncommon-words
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 [S2...]
    to find uncommon words in the strings S1, S2...
    FIN
my %count;
$count{lc $_}++ for split /\W+/, "@ARGV";
my @output=sort {$a cmp $b} grep {$count{$_}==1} keys %count;
push @output, "''" unless @output;
say join " ", map({"'".$_."'"} @ARGV), "->", @output;
