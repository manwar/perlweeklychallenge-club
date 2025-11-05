#!/usr/bin/env perl
# Perl weekly challenge 346
# Task 1:  Longest Parenthesis
#
# See https://wlmb.github.io/2025/11/02/PWC346/#task-1-longest-parenthesis
use v5.36;
use feature qw(try);
use List::Util qw(max);
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to find the longest sequence of correctly nested parenthesis, where
    Si is a string formed of any number of parenthesis "(" and ")".
    FIN
for(@ARGV){
    try {
	die "Expected only round parenthesis" unless /^[()]*$/;
	my $input=$_;
	1 while s/((\d*)\((\d*)\))/+($2||0)+($3||0)+2/e;
	say "$input -> ", max 0, /\d+/g;
    }
    catch($e){warn $e}
}
