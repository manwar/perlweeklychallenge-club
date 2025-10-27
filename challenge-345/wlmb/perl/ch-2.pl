#!/usr/bin/env perl
# Perl weekly challenge 345
# Task 2:  Last Visitor
#
# See https://wlmb.github.io/2025/10/27/PWC345/#task-2-last-visitor
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV;
    Usage: $0 A0 A1...
    where An is a string with space separated numbers, positive
    or -1. For each run of -1's output the previously seen positive
    numbers, or -1 if they have been exhausted.
    FIN
for(@ARGV){
    try {
	my $count=0; # count of succesive -1's
	my @answer = my @seen =();
	my @input = split " ";
	for(@input){
	    unshift(@seen, $_), $count=0, next if $_ > 0;
	    die "Only positive numbers and -1 are allowed: $_"
		unless $_ == -1;
	    push @answer, $count<@seen? $seen[$count]:-1;
	    ++$count;
	}
	say "[$_] -> [@answer]";
    }
    catch($e){warn $e;}
}
