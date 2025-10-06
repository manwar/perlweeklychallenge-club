#!/usr/bin/env perl
# Perl weekly challenge 342
# Task 1:  Balance String
#
# See https://wlmb.github.io/2025/10/06/PWC342/#task-1-balance-string
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 S2...
    to balance each string S1 so that letters and lower case characters
    intermingle.
    FIN
for(@ARGV){
    try {
	my(@digits, @letters, @output);
	for(split ""){
	    die "Expected only digits or lowercase letters: $_" unless /\d|[a-z]/;
	    push @digits, $_ if /\d/;
	    push @letters, $_ if /[a-z]/;
	}
	#print"$_ -> ";
	say("$_ ->"),next unless abs(@digits - @letters) <= 1;
	@digits = sort {$a cmp $b} @digits;
	@letters = sort {$a cmp $b} @letters;
	if(@digits >= @letters){
	    push @output, shift @digits, shift @letters while @letters;
	    push @output, @digits; # if there were one more digit than letters
	    say "$_ -> ", join "", @output;
	    next
	}
	# @digits < @letters
	push @output, shift @letters, shift @digits  while @digits;
	push @output, @letters; # remaining letter
	say "$_ -> ", join "", @output;
    }
    catch($e){
	warn $e;
    }
}
