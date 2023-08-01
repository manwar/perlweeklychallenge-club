#!/usr/bin/env raku
=begin comment
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-01
Challenge 228 Task 2 Empty Array ( Raku )
---------------------------------------
=end comment
use v6;

my @myints = ([3, 4, 2],[1,2,3]);

for (@myints) -> @i {
    say "Input: \@int = ",@i;
    my $cnt = 0;
    while @i.elems {
        my $min = @i.min;
        if (@i[0] == $min) {
            @i.shift;
        } else {
            @i.push: @i[0];
            @i.shift;
        }
        @i.elems > 0 ?? say @i !! say "()";
        $cnt++;
    }
    say "Output: $cnt\n";
}

=begin comment
---------------------------------------
SAMPLE OUTPUT
raku .\EmptyArray.rk

Input: @int = [3 4 2]
[4 2 3]
[2 3 4]
[3 4]
[4]
()
Output: 5

Input: @int = [1 2 3]
[2 3]
[3]
()
Output: 3
---------------------------------------
=end comment



