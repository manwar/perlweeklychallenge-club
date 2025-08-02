#!/usr/bin/env perl
# Perl weekly challenge 257
# Task 2:  Reduced Row Echelon. PDL solution
#
# See https://wlmb.github.io/2024/02/20/PWC257/#task-2-reduced-row-echelon
use v5.36;
use PDL;
use PDL::NiceSlice;
die <<~"FIN" unless @ARGV;
    Usage: $0 M1 [M2...]
    to check if the matrices Mn is a reduced row echelon matrix.
    The matrices are strings of the form
    "[[M11 M12..][M21 M22...]...]" where each Mij is a number,
    the element in the i-th row and j-th column.
    FIN
for(@ARGV){
    my $matrix=pdl($_);
    my $extended_matrix=pdl(0)->glue(0, $matrix, identity($matrix->dim(1)));
    my ($freq,$vals)=$extended_matrix->rle; # run length encode
    $freq=$freq((0));                       # number of leading zeroes
    my $result=all($freq==$freq->qsort);    # check non-decreasing
    $result &&= all($vals((1))==1);         # leading non-zero is 1
    for(1..$matrix->dim(1)-1){
	my $j=$freq(($_));                  # position of first non zero of $_ row
	$result &&= all($extended_matrix(($j),0:$_-1)==0)
    }
    say "$matrix -> $result"
}
