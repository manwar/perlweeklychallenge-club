#!/usr/bin/env perl
# Perl weekly challenge 217
# Task 1:  Sorted Matrix
#
# See https://wlmb.github.io/2023/05/15/PWC217/#task-1-sorted-matrix
use v5.36;
use PDL;
use experimental "try";
die <<~"FIN" unless @ARGV;
    Usage: $0 '[[m11, m22, ...],[m21,m22,...],...]'
    to find the third element of the sorted matrix elements mij.
    FIN
for(@ARGV){
    try {
	my $x=pdl($_); # Convert input string to pdl-ndarray
	die "Expected a square matrix: $_"
	    unless $x->isa("PDL") and $x->dims==2 and $x->dim(0)==$x->dim(1);
	my $result=$x
	    ->flat   # convert to vector
	    ->qsort  # sort its elements
	    ->at(2); # choose third smallest
	say "$x->$result";
    }
    catch($e){
	warn "$e";
    }
}
