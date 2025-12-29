#!/usr/bin/env perl
# Perl weekly challenge 354
# Task 1:  Min Abs Diff
#
# See https://wlmb.github.io/2025/12/28/PWC354/#task-1-min-abs-diff
use v5.36;
use feature qw(try);
use PDL;
use PDL::NiceSlice;
die <<~"FIN" unless @ARGV;
    Usage: $0 L0 L1...
    to find the pairs of numbers from each list Ln whose
    difference has a minimum absolute value.
    Each Ln is a string of the form "[N0 N1...]", suitable
    as input to pdl.
    FIN
for(@ARGV){
    try {
	my $sorted=pdl($_)->uniq->qsort;
	my $diff=$sorted(1:)-$sorted(:-2);    # differences of consecutive pairs
	my $indices=which($diff==$diff->min); # choose first indices of pairs
	my $result=pdl(                       # consecutive pairs
	    $sorted->index($indices), $sorted->index($indices+1)
	    )->mv(0,1);                       # transpose
	say "$_ -> $result";
    }
    catch($e){ warn $e; }
}
