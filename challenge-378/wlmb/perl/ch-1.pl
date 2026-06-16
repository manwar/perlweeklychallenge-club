#!/usr/bin/env perl
# Perl weekly challenge 378
# Task 1:  Second Largest Digit
#
# See https://wlmb.github.io/2026/06/15/PWC378/#task-1-second-largest-digit
use v5.36;
use List::Util qw(uniq);
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to find the second largest digit in string Sn
    FIN
for(@ARGV){
    say "$_ -> ",
	(
	 sort {$b<=>$a} # reverse sort
	 uniq           # unique digits
	 grep{/[0-9]/}  # only keep digits
	 split ""       # split in characters
	)               # list of sorted unique digits
	[1]             # take second element
	//-1            # or -1 if not defined
}
