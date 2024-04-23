#!/usr/bin/env perl
# Perl weekly challenge 266
# Task 2:  X Matrix
#
# See https://wlmb.github.io/2024/04/21/PWC266/#task-2-x-matrix
use v5.36;
use PDL;
use PDL::NiceSlice;
die <<~"FIN" unless @ARGV;
    Usage: $0 M1 [M2...]
    to find out if the matrices M1, M2... are X shaped.
    Each matrix should be of the form "[[M11 M12...][M21 M22...]...]"
    where Mij are the matrix elements. Separating commas are optional.
    FIN
for(@ARGV){
    my $matrix=pdl $_;
    my $x=($matrix->xvals==$matrix->yvals) | ($matrix->xvals->(-1:0)==$matrix->yvals);
    my $output=(!!$matrix == $x)->all?"True":"False";
    say "$matrix -> $output";
}
