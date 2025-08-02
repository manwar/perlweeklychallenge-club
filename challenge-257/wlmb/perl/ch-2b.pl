#!/usr/bin/env perl
# Perl weekly challenge 257
# Task 2:  Reduced Row Echelon. More compact, eliminate Perl loop in
#                               PDL solution
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
    my $result=all($freq==$freq->qsort)     # check non-decreasing
                                            # check leading 1 and 0
	                                    # elsewhere in column
	&& all($extended_matrix->index1d($freq)==identity($freq->dim(0)));
    say "$matrix -> $result"
}
