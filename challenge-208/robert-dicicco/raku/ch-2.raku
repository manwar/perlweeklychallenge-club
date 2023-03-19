#!/usr/bin/env raku
#`{
----------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-15
Challenge 208 'Duplicate and Missing' ( Raku )
----------------------------------------------
}

my @nums = ([1,2,2,4],[1,2,3,4],[1,2,3,3]);

for (@nums) -> @a {
    my $found = 0;
    say "Input: \@nums = ",@a;
    my $ln = @a.elems;
    for 0..$ln-1 -> $n {
        if @a[$n] != $n+1 {
           say "Output: (@a[$n],",$n+1,')';
           $found = 1;
        }
    }
    if $found == 0 {
        say "Output: -1";
    }
    say " ";
}
#`{
----------------------------------------------
SAMPLE OUTPUT
raku .\DupMissing.rk
Input: @nums = [1 2 2 4]
Output: (2,3)

Input: @nums = [1 2 3 4]
Output: -1

Input: @nums = [1 2 3 3]
Output: (3,4)
----------------------------------------------
}
