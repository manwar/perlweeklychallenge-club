#!/usr/bin/env perl
# Perl weekly challenge 378
# Task 2:  Sum of Words
#
# See https://wlmb.github.io/2026/06/15/PWC378/#task-2-sum-of-words
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to see if the sum of the numbers associated
    to the first two space separated substrings
    of Sn sum to the third. The first letters are
    mapped to the first digits.
    FIN
for(@ARGV){
    try {
	die "Only a-j are valid characters: $_ " unless /^[a-j\s]*$/;
	my @words = split " ";
	die "Expected three space separated strings: $_" unless @words==3;
	my @numbers = map {tr/a-j/0-9/r} @words;
	my $result =  $numbers[2]==$numbers[0]+$numbers[1]?"True":"False";
	say "$_ -> $result";
    }
    catch($e){ warn $e; }
}
