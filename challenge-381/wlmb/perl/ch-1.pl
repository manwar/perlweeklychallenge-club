#!/usr/bin/env perl
# Perl weekly challenge 381
# Task 1:  Same Row Column
#
# See https://wlmb.github.io/2026/07/06/PWC381/#task-1-same-row-column
use v5.36;
use feature qw(try);
use PDL;
die <<~"FIN" unless @ARGV;
    Usage: $0 M0 M1...
    to find if all rows and columns of the NxN matrix Mn contain
    all the numbers 1..N.
    Mn are strings that may be interpreted by PDL as matrices.
    FIN
for(@ARGV){
    try {
	my $matrix = pdl $_;
	die "Matrix must be square" unless
	    $matrix->ndims==2 && $matrix->dim(0)==$matrix->dim(1);
	my $seq = 1 + sequence($matrix->dim(0));
	say "$matrix-> ",
	    pdl(
		map{($_->qsort==$seq)->all}$matrix, $matrix->transpose
	    )->all?"True":"False";
    }
    catch($e) {warn $e;}
}
