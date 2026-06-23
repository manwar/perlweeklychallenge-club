#!/usr/bin/env perl
# Perl weekly challenge 379
# Task 2:  Armstrong Number
#
# See https://wlmb.github.io/2026/06/22/PWC379/#task-2-armstrong-number
use v5.36;
use List::Util qw(sum);
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 B0 L0 B1 L1...
    to list all Armstrong numbers up to Ln in base Bn
    FIN
for my($base, $limit)(@ARGV){
    my @result;
    my @digits = (-1);
    for(0..$limit){
	for(0..@digits){ # increment by 1
	    last unless ++$digits[$_] == $base; # last unless overflow
	    $digits[$_] = 0;                    # reset overflowed digit
	}
	push @result, $_ if (sum map {$_**@digits} @digits) == $_;
    }
    say "base=$base, limit=$limit -> @result";
}
