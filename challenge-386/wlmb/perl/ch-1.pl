#!/usr/bin/env perl
# Perl weekly challenge 386
# Task 1:  Reverse Base
#
# See https://wlmb.github.io/2026/08/10/PWC386/#task-1-reverse-base
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 N0 B0 N1 B1...
    to convert the number Ni from the base Bi to base 10.
    FIN
my @digits=(0..9,"A".."Z","a".."z","+","/");
my %to_decimal;
$to_decimal{$digits[$_]}=$_ for 0..@digits-1;

for my($num, $base)(@ARGV){
    try {
	die "Base should be a positive integer > 1: $base"
	    unless $base=~/^\d+$/ && $base > 1;
	die "I can't handle bases larger than 64: $base"
	    unless $base <=64;
	my $result = 0;
	for(split "", $num){
	    die "Undefined digit: $_" unless defined(my $dec=$to_decimal{$_});
            die "Undefined digit in base $base: $_" unless $dec < $base;
            $result = $result*$base+$dec;
	}
	say "Num.= $num, base=$base -> $result";
    }
    catch($e){warn $e;}
}
