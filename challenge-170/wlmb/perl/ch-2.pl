#!/usr/bin/env perl
# Perl weekly challenge 170
# Task 2: Kronecker product
#
# See https://wlmb.github.io/2022/06/20/PWC170/#task-2-kronecker-product
use v5.12;
use warnings;
use PDL;
use PDL::NiceSlice;
die "Usage: ./ch-2.pl A B\nto obtain the Kronecker product of A and B" unless @ARGV==2;
# The input matrices should be written as an array of rows, each row
# as an array of numbers and within quotes, as in  "[[1,2,3],[4,5,6]]"
# for a 2x3 matrix
my ($A, $B)=map {pdl $_} @ARGV;
my $C=$A(*1,*1,:,:)*$B(:,:,*1,*1); #use dummy indices to build tensor
                                   #product # C_{ijkl}=A_{ij}B_{kl}
# Notice: PDL uses column,row notation, not the algebraic row, column
# Get size of each dimension
my ($I, $J, $K, $L)=($A->dim(1), $A->dim(0), $B->dim(1), $B->dim(0));
my $Kronecker=$C->mv(1,2) # change indices to ikjl
    ->reshape($J*$L, $I*$K); # clump indices i and k, and j and l
say "The Kronecker product of $A and $B is $Kronecker";
