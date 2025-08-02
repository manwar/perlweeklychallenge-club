#!/usr/bin/env perl
# Perl weekly challenge 325
# Task 2:  Final Price
#
# See https://wlmb.github.io/2025/06/09/PWC325/#task-2-final-price
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 P1 P2...
    to apply discount to prices P1 P2...
    A discount consists of subtracting from Pn the next possible Pm.
    FIN
my @results=@ARGV;
for(0..@results-1){
    for my $j($_+1..@results-1){
	my $discounted=$results[$_]-$results[$j];
	$results[$_]=$discounted,last if $discounted>=0;
    }
}
say "@ARGV -> @results"
