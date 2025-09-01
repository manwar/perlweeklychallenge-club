#!/usr/bin/env perl
# Perl weekly challenge 337
# Task 2:  Odd Matrix
#
# See https://wlmb.github.io/2025/08/31/PWC337/#task-2-odd-matrix
use v5.36;
use PDL;
use PDL::NiceSlice;
use feature qw(try);
die <<~"FIN" unless @ARGV and @ARGV%3==0;
    Usage: $0 R1 C1 P1 R2 C2 P2...
    to find how many odd numbers are in a matrix of Ri rows and Ci columns
    after the rows and columns corresponding to the points Pi are incremented,
    where Pi is input as a string with the format "[[r1 c1][r2 c2]...]"
    FIN
for my($rows,$cols,$points)(@ARGV){
    try {
	my $matrix=zeroes($cols,$rows);
	my $locations=pdl($points);
	$matrix(($_))++ for $locations->slice("(1)")->dog;  # increment columns
	$matrix(,($_))++ for $locations->slice("(0)")->dog; # increment rows
	say "Rows=$rows, Cols=$cols, Locations=$points -> ", ($matrix%2)->sum
    } catch($e) { say $e;}
}
