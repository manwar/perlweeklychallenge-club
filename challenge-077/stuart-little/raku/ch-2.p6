#!/usr/bin/env perl6
use v6;

sub lnly(@a) {
    ((^@a.elems) X (^@a[0].elems))
    .grep({ @a[$_[0]][$_[1]] && (@a[$_[0]][$_[1]] eq 'x') })
    .map({ (($_.[0] X+ (0,-1,1)).grep(*>=0) X ($_.[1] X+ (0,-1,1)).grep(*>=0)).[1..*]  })
    .map({ $_.grep({ @a[$_[0]][$_[1]] }).map({ @a[$_[0]][$_[1]] }) })
    .map(*.join).grep(* !~~ /x/)
    .elems
}

say lnly(@*ARGS.map(*.split('', :skip-empty)));

# run as <script> <space-separated strings representing the rows of the matrix>
# <script> x0x 00x 00x inputs the matrix
# x0x
# 00x
# 00x
# 
