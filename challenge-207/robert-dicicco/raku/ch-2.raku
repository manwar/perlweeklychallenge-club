#!/usr/bin/env raku
#`(
----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-07
Challenge 207 H-Index ( Raku)
==================================
)
use v6;

my @citations = ([10,8,5,4,3],[25,8,5,3,3]);

sub CalcIndex(@c) {
    my $ln = @c.elems;
    my $offset = $ln;
    $offset = $ln-1;
    my $pos = $ln;
    while $offset >= 0 {
        if @c[$offset] >= $pos {
            say "Output: $pos\n";
            return;
        } else {
            $offset--;
            $pos--;
        }
    }

}

for (@citations) -> @c {
    say "Input: \@citations = ",@c;
    CalcIndex(@c);
}

#`(
----------------------------------
SAMPLE OUTPUT
 raku .\HIndex.rk
Input: @citations = [10 8 5 4 3]
Output: 4

Input: @citations = [25 8 5 3 3]
Output: 3
----------------------------------
)


