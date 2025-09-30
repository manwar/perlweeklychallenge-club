#!/usr/bin/env perl
# Perl weekly challenge 341
# Task 1:  Broken Keyboard
#
# See https://wlmb.github.io/2025/09/29/PWC341/#task-1-broken-keyboard
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 S1 K1 S2 K2...
    to count how many words in string Si are free of the broken keys
    that make string Ki.
    FIN
for my ($string, $keys)(@ARGV){
    try {
	die "Broken keys should correspond to word chars: $keys"
	    unless $keys=~/^\w*$/;
	my $result =                          # count filtered words (convert to scalar)
	    grep {$keys eq "" || !/[$keys]/i} # no broken keys, or don't match them
            	 split /\W+/, $string;        # split on non-word chars
	say "String=$string; Broken keys=$keys -> $result";
    }
    catch($e){
	warn $e;
    }
}
