#!/usr/bin/env perl
# Perl weekly challenge 387
# Task 1:  Reverse Base
#
# See https://wlmb.github.io/2026/08/17/PWC387/#task-1-rearrenge-binary-string
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV;
    Usage: $0 B0 B1...
    to find hao many transpositions of 01 have to be done in parallel
    to order all 1's before all 0's inbinary string Bn
    FIN
for(@ARGV){
    try{
	die "Expected binary string: $_" unless /^(0|1)+$/;
	my $in=$_;
	my $count=0;
	++$count while s/01/10/g;
	say "$in -> $count"
    }
    catch($e){warn $e}
}
