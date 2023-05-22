#!/usr/bin/env raku
use v6;
=begin comment
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-15
Challenge 217 Max Number ( Raku )
---------------------------------------
=end comment


my @list = ([5,11,4,1,2],[31, 2, 4,10],[10,3,2],[1, 23],[1,10]);
my $max = 0;

for (@list) -> @lst {
    print("Input: @list = ",@lst,"\n");
    for @lst.permutations -> $p {
        my $num = $p.join;
        if $num > $max {
            $max = $num;
        }
    }
    say "Output: $max\n";
    $max = 0;
}

=begin comment
---------------------------------------
SAMPLE OUTPUT
raku MaxNumber.rk
Input: @list = 5 11 4 1 2
Output: 542111

Input: @list = 31 2 4 10
Output: 431210

Input: @list = 10 3 2
Output: 3210

Input: @list = 1 23
Output: 231

Input: @list = 1 10
Output: 110
---------------------------------------
=end comment


