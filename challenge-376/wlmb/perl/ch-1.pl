#!/usr/bin/env perl
# Perl weekly challenge 376
# Task 1:  Chessboard Squares
#
# See https://wlmb.github.io/2026/06/01/PWC376/#task-1-chessboard-squares
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 P0 Q0 P1 Q1...
    to find if positions Pn Qn on a chess board have
    the same color.
    FIN
for my($p,$q)(@ARGV){
    try {
	do {die "Invalid position: $_" unless /^[a-h][1-8]/} for $p, $q;
	my ($horizontalP, $verticalP, $horizontalQ, $verticalQ)
	    = map {split ""} ($p, $q);
	($horizontalP, $horizontalQ) = map {ord} ($horizontalP, $horizontalQ);
	my $steps = $horizontalP-$horizontalQ+$verticalP-$verticalQ;
	say "$p $q -> ", $steps%2?"False":"True";
    }
    catch($e){warn $e}
}
