#!/usr/bin/env perl
# Perl weekly challenge 331
# Task 1:  Last Word
#
# See https://wlmb.github.io/2025/07/21/PWC331/#task-1-last-word
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 S2...
    to find the length of the last word of the strings Sn
    FIN
for(@ARGV){
    say "$_ -> ",        # print the result
	length           # compute the length
	[split " "]      # separate into words
	->[-1]           # choose last word
	=~s/\W//gr       # remove non-word characters
}
