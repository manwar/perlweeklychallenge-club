#!/usr/bin/env perl
# Perl weekly challenge 349
# Task 1:  Power String
#
# See https://wlmb.github.io/2025/11/24/PWC349/#task-1-power-string
use v5.36;
use List::Util qw(max);
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to find the power of the strings S0, S1...,
    i.e., the longest substring of repeated characters.
    FIN
for(@ARGV){
    my $in = $_;
    my $length = 0;
    while(s/^((.)\2*)//){
	my $l = length $1;
	$length = $l if $l > $length;
    }
    say "$in -> $length";
}
