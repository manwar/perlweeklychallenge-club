#!/usr/bin/env perl
# Perl weekly challenge 270
# Task 1:  Special Positions
#
# See https://wlmb.github.io/2024/05/20/PWC270/#task-1-special-positions
use v5.36;
use PDL;
die <<~"FIN" unless @ARGV;
    Usage: $0 M1 M2...
    where M1, M2... are strings that represent matrices, of the form
    "[[m11 m12...][m21 m22...]...]"
    FIN
for(@ARGV){
    my $x=pdl($_);
    say "$x -> ",
	(($x) # value is not zero
	 &(($x->borover==1)->dummy(0)) # only 0's and 1's in row
	 &(($x->transpose->borover==1)->dummy(1)) # only 0's and 1's in column
	 &(($x->sumover==1)->dummy(0)) # only one 1 in row
	 &(($x->transpose->sumover==1)->dummy(1)) # only one 1 in column
	)->sum;
}
