#!/usr/bin/env perl
# Perl weekly challenge 352
# Task 2:  Binary Prefix
#
# See https://wlmb.github.io/2025/12/16/PWC352/#task-2-binary-prefix
use v5.36;
use feature qw(try);
use List::Util qw(reductions);
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to find which left substrings of the binary strings Sn correspond to
    binary numbers divisible by 5.
    FIN
my @convert=(0..4)x2;
for(@ARGV){
    try {
	die "Not a binary string: $_" unless /^[01]+$/;
	my @digits=split "";
	say "$_ -> ", map {$_?"False ":"True "}
	              reductions{$convert[2*$a+$b]}@digits;
    }
    catch($e){warn $e;}
}
