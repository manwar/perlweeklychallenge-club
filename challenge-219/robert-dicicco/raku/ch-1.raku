#!/usr/bin/env raku
=begin comment
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-29
Challenge 219 Sorted Squares Task 1 ( Raku )
--------------------------------------
=end comment
use v6;

my @list = ([-2, -1, 0, 3, 4],
            [5, -4, -1, 3, 6]
            );
my $cnt = @list.elems ;

for (@list) -> @lst {
    say "Input: \@list = ",@lst;
    my @squared_array = map(-> $x {$x ** 2},@lst).sort.join(',');
    say "Output: ",@squared_array,"\n";
}

=begin comment
--------------------------------------
SAMPLE OUTPUT
raku .\SortedSquares.rk

Input: @list = [-2 -1 0 3 4]
Output: [0,1,4,9,16]

Input: @list = [5 -4 -1 3 6]
Output: [1,9,16,25,36]
--------------------------------------
=end comment


