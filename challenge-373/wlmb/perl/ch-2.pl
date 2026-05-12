#!/usr/bin/env perl
# Perl weekly challenge 373
# Task 2:  List Division
#
# See https://wlmb.github.io/2026/05/11/PWC373/#task-2-list-division
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 L0 N0 L1 N1...
    to split the space separated list Ln into Nn (almost) equal parts.
    FIN
for my ($list, $pieces)(@ARGV){
    try {
	die "Number of pieces must be >= 1: $pieces" unless $pieces >= 1;
	my @list = split " ", $list;
	my $size = @list / $pieces;
	my $remainder = @list % $pieces;
	my @result = $pieces > @list
	    ? -1
	    : map{
		"("
		    . join(" ", splice(@list, 0, $size + ($_<=$remainder)))
		    .")"
	      } (1 .. $pieces);
	say "$list, $pieces -> @result";
    }
    catch($e){ warn $e }
}
