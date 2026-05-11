#!/usr/bin/env perl
# Perl weekly challenge 372
# Task 2:  Largest Substring
#
# See https://wlmb.github.io/2026/05/04/PWC372/#task-2-largest-substring
use v5.36;
use List::Util qw(max uniq);
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to find the length of the largest substring of Sn
    between equal characters
    FIN
for(@ARGV){
    my $input = $_;
    say "$_ -> ",
	max
	map {$input =~ m/$_(.*)$_/?length($1):-1;}
        uniq
	split "";
}
