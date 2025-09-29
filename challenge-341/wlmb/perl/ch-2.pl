#!/usr/bin/env perl
# Perl weekly challenge 341
# Task 2:  Reverse Prefix
#
# See https://wlmb.github.io/2025/09/29/PWC341/#task-2-reverse-prefix
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV && @ARGV%2==0;
    Usage: $0 S1 C1 S2 C2...
    to reverse the first characters of the string Si,
    up to the character Ci.
    FIN
for my($string, $character)(@ARGV){
    try{
	die "Expected a single character: $character" unless length $character == 1;
	my $original = $string;
	$string =~ s/^(.*?$character)/reverse $1/e;
	say"String=$original, character=$character -> $string";
    }
    catch($e){
	warn $e;
    }
}
