#!/usr/bin/env perl
# Perl weekly challenge 365
# Task 1:  Alphabet Index Digit Sum
#
# See https://wlmb.github.io/2026/03/16/PWC365/#task-1-alphabet-index-digit-sum
use v5.36;
use feature qw(try);
use List::Util qw(sum);
my %letter_to_number;
@letter_to_number{"a".."z"}=(1..26);
die <<~"FIN" unless @ARGV && @ARGV%2==0;
    Usage: $0 S0 k0 S1 k1...
    to convert the string Sn to digits and sum them kn times.
    FIN
for my($str, $k)(@ARGV){
    try {
	die "Only lower case letter allowed: $str" unless $str=~/^[a-z]+$/;
	my $x= join "", map {$letter_to_number{$_}}  split "",$str;
	$x=sum split "",$x for(1..$k);
	say"$str, $k -> $x";
    }
    catch($e) { warn $e; }
}
