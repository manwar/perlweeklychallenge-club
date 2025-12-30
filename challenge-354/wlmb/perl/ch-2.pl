#!/usr/bin/env perl
# Perl weekly challenge 354
# Task 2:  Shift Grid
#
# See https://wlmb.github.io/2025/12/28/PWC354/#task-2-shift-grid
use v5.36;
use feature qw(try);
use PDL;
use PDL::NiceSlice;
die <<~"FIN" unless @ARGV && @ARGV%2==0;
    Usage: $0 M0 k0 M1 k1
    to shift the matrix Mn kn times.
    Each shift consists of rotating the matrix one position
    towards the right and rotating the first column downwards.
    Each Mn is a string of the form "[[m00 m01...][m10 m11...]...]"
    that may be intepreted by pdl.
    FIN
for my($input,$k)(@ARGV){
    try {
	my $result=(my $matrix=pdl($input))->copy;
	for(1..$k){
	    $result.=$result->rotate(1);                # shift right
	    $result((0)).=$result((0))->rotate(1); # shift first column down
	}
	say"$matrix $k -> $result"
    }
    catch($e) { warn $e }
}
