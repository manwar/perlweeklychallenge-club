#!/usr/bin/env perl
# Perl weekly challenge 248
# Task 2:  Submatrix Sum
#
# See https://wlmb.github.io/2023/12/17/PWC248/#task-2-submatrix-sum
use v5.36;
use PDL;
use PDL::NiceSlice;
die <<~"FIN" unless @ARGV==1;
    Usage: $0 M
    to sum 2x2 the overlapped submatrices of matrix M
    FIN
my $m=pdl(shift);
my $n=pdl($m(0:-2,0:-2),$m(1:-1,0:-2),$m(0:-2,1:-1),$m(1:-1,1:-1))
    ->mv(-1,0)->sumover;
say "$m->$n"
