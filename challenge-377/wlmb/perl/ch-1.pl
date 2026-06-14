#!/usr/bin/env perl
# Perl weekly challenge 377
# Task 1:  Reverse Existence
#
# See https://wlmb.github.io/2026/06/08/PWC377/#task-1-reverse-existence
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to test if the reversed string Sn when reversed
    contains a two character substring of the original string.
    FIN
STRING: for my $string (@ARGV){
    for(map{"".reverse $_}      # reverse each substring
	$string=~/(?=(..))/g    # get all 2 char substrings
	){
	say("$string -> True"), next STRING
	    if $string=~/$_/;
    }
    say "$string -> False";
}
