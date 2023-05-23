#!/usr/bin/en raku
=begin comment
-----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-22
Challenge 218 Maximum Product ( Raku )
-----------------------------------------
=end comment

my @lists = ([3, 1, 2],[4, 1, 3, 2],[-1, 0, 1, 3, 1],[-8, 2, -9, 0, -4, 3]);

my $maxval = 0;

my $threelist = 0;
my @threelist = ();

for (@lists) -> @lst {
    for @lst.combinations(3) -> @combo {
        my $threeval = [*] @combo;
        if $threeval > $maxval {
            $maxval = $threeval;
            @threelist = @combo;
        }
    }
    say "Input: \@list = ",@lst;
    say "Output: ",$maxval;
    @threelist = @threelist.sort;
    say @threelist[0], " x ", @threelist.[1], " x ", @threelist[2], " = $maxval";
    @threelist = ();
    $maxval = 0;
    say "";
}

=begin comment
-----------------------------------------
SAMPLE OUTPUT

raku .\MaxProduct.rk
Input: @list = [3 1 2]
Output: 6
1 x 2 x 3 = 6

Input: @list = [4 1 3 2]
Output: 24
2 x 3 x 4 = 24

Input: @list = [-1 0 1 3 1]
Output: 3
1 x 1 x 3 = 3

Input: @list = [-8 2 -9 0 -4 3]
Output: 216
-9 x -8 x 3 = 216
-----------------------------------------
=end comment


