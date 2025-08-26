#!/usr/bin/env perl
# Perl weekly challenge 336
# Task 2:  Final Score
#
# See https://wlmb.github.io/2025/08/25/PWC336/#task-2-final-score
use v5.36;
use List::Util qw(sum0);
use feature qw(try);
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 S2...
    to perform the space separated operations Oj  in strings Si
    and print the resulting score.
    The operations are
       a number, push it
       +, push the sum of the last two numbers
       C, clear the last number
       D, push twice the last number
    FIN
for(@ARGV){
    my @scores;
    try {
	for(split " "){
	    push(@scores, ($scores[-1]//0)+($scores[-2]//0)), next if /^\+$/;
	    push(@scores, ($scores[-1]//0)*2), next if /^D|d$/;
	    @scores&&pop(@scores), next if /^C|c$/;
	    push(@scores, $_), next if /^(\+|-)?\d+$/;
	    die "Expected +, D, C or number: $_";
	}
	say "$_ -> ", sum0 @scores;
    } catch($e) {
	say $e;
    }
}
