#!/usr/bin/env raku
#`{
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-01
Challenge 215 Odd One Out ( Raku )
----------------------------------------
}
my @words = ('abc', 'xyz', 'tsu'),('rat', 'cab', 'dad'),('x', 'y', 'z');

for (@words) -> @wds {
    my $cnt = 0;
    say "Input: \@words = ", @wds;
    for (@wds) -> $w {
        if $w ne $w.comb.sort.join {
            $cnt++;
        }
    }
    say "Output: ", $cnt;
    say " ";
}

#`{
----------------------------------------
SAMPLE OUTPUT
raku .\OddOneOut.rk
Input: @words = (abc xyz tsu)
Output: 1

Input: @words = (rat cab dad)
Output: 3

Input: @words = (x y z)
Output: 0
}



