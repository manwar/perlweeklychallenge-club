#!/usr/bin/env perl
# Perl weekly challenge 293
# Task 1:  Similar Dominos
#
# See https://wlmb.github.io/2024/10/28/PWC293/#task-1-similar-dominos
use v5.36;
use PDL;
use PDL::NiceSlice;
die <<~"FIN" unless @ARGV;
    Usage: $0 D1 D2...
    to find how many similar dominoes are in the set D1 D2...
    Di is a string of the form [[a1 b1][a2 b2][a3 b3]...] where
    each pair [an bn] represent a single domino.
    FIN
for(@ARGV){
    my @dominoes = sort {$a((0)) <=> $b((0)) || $a((1))<=>$b((1))} pdl($_)->qsort->dog;
    my $similar = 0;
    my $in_group = 0;
    for(0..@dominoes-2){
        if(($dominoes[$_]==$dominoes[$_+1])->all){
            ++$similar if !$in_group;
            ++$in_group;
            ++$similar;
        } else {
            $in_group=0;
        }
    }
    say "$_ -> $similar";
}
