#!/usr/bin/env perl
# Perl weekly challenge 339
# Task 1:  Max Diff
#
# See https://wlmb.github.io/2025/09/15/PWC339/#task-1-max-diff
use v5.36;
use feature qw(try);
use PDL;
use PDL::NiceSlice;
die <<~"FIN" unless @ARGV;
    Usage: $0 A0 A1...
    to find the maximum difference between products of disctinct
    elements of the arrays A0, A1... Each array is input as a string
    of the form "[X0 X1...]" that can be read by PDL
    FIN
for(@ARGV){
    try {
	my $in=pdl($_);
	my $products=$in*$in(*1);
	my $diffs=$products-$products(*1,*1);  # Xi*Xj-Xk*Xl
	my ($i, $j, $k, $l) = $diffs->ndcoords->mv(0,-1)->dog; #coordinates into ndarray $diffs
	$diffs=$diffs->where(
	    ($i!=$j)&($i!=$k)&($i!=$l)
	    &($j!=$k)&($j!=$l)
	    &($k!=$l));  # select elements with no repeating coordinates
	say "$_ -> ", $diffs->max;
    }
    catch($e){
	warn $e;
    }
}
