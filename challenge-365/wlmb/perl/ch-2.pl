#!/usr/bin/env perl
# Perl weekly challenge 365
# Task 2:  Valid Token Counter
#
# See https://wlmb.github.io/2026/03/16/PWC365/#task-2-valid-token-counter
use v5.36;
die <<~ "FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to count valid space-separated tokens in the strings Sn
    FIN
for(@ARGV){
    say "$_ -> ",
	0+
	grep {/^[[:alpha:]]+(-[[:alpha:]]+)?[\.,!]?$/}
        split " "
}
