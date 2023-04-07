#!/usr/bin/env perl
# Perl weekly challenge 211
# Task 1:  Toeplitz Matrix
#
# See https://wlmb.github.io/2023/04/03/PWC211/#task-1-toeplitz-matrix
use v5.36;
use List::Util qw(max min uniq);
my @matrix;
my $N=0; # number of rows
while(<>){ # read the matrix, a space separated row at a time
    $matrix[$N++]=[split " "];
}
my $M=@{$matrix[0]}; # Number of columns
@{$matrix[$_]}==$M || die "Not rectangular"  for(1..$N-1);
my $largest=max($N,$M);
my $toeplitz=1;      # matrix is toeplitz
for my $diagonal(-$M+1..$N-1){
    $toeplitz &&=    # unless it is not
        1==uniq
	map {$matrix[$diagonal+$_][$_]}
        max(0, -$diagonal)..min($M-1,$N-$diagonal-1);
}
say "@{$matrix[$_]}" for 0..$N-1;
say " -> ", $toeplitz?"true":"false";
