#!/usr/bin/env perl
# Perl weekly challenge 351
# Task 2:  Arithmetic Progression
#
# See https://wlmb.github.io/2025/12/08/PWC351/#task-2-arithmetic-progression
use v5.36;
use feature qw(try);
use PDL;
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to find if the arrays Sn correspond to an arithmetic progression.
    Sn are strings with the format "[N0 N1...]" where Nn are numbers.
    FIN
for(@ARGV){
    try {
	my $in=pdl($_);
	my $sorted = $in->qsort;
	my $second_diff=$sorted->conv1d(pdl[1,-2,1]) # second differences
	    ->slice("1:-2");               # remove first and last el.
	my $result=($second_diff==0)->all?"True":"False";
	say "$_ -> $result";
    }
    catch($e){
	warn $e;
    }
}
