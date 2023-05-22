#!/usr/bin/env raku
use v6;
=begin comment
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-15
Challenge 217 Sorted Matrix ( Perl )
--------------------------------------
=end comment

my @matrix = <3 1 2 5 2 4 0 1 3>,<2 1 4 5>,<1 0 3 0 0 0 1 2 1>;

for (@matrix) -> @sub {
    say "Input: \@matrix = ",@sub;
    say "Output: ", @sub.sort[2];
}
=begin comment
--------------------------------------
SAMPLE OUTPUT
raku SortedMatrix.rk
Input: @matrix = (3 1 2 5 2 4 0 1 3)
Output: 1

Input: @matrix = (2 1 4 5)
Output: 4

Input: @matrix = (1 0 3 0 0 0 1 2 1)
Output: 0
--------------------------------------
=end comment
