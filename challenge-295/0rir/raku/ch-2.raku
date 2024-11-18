#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
INIT die 'Rakudo version is too old; need max with named args.'
     unless $*RAKU.compiler.version cmp v2023.07 == More;
use Test;

=begin comment
295-2: Jump Game            Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.

Write a script to find the minimum number of jumps to reach the last element. $ints[$i] represents the maximum length of a forward jump from the index $i. In case last element is unreachable then return -1.

Example 1
Input: @ints = (2, 3, 1, 1, 4)
Output: 2

Jump 1 step from index 0 then 3 steps from index 1 to the last element.
Example 2
Input: @ints = (2, 3, 0, 4)
Output: 2
Example 3
Input: @ints = (2, 0, 0, 4)
Output: -1


=end comment

my @Test =
    # in                    exp
    (0,),                   0,
    (9,),                   0,
    #(1,0),                 1,
    #(0,1),               Int,
    #(9,0),                 1,
    (2, 3, 1, 1, 4),        2,
    (2,-3, 1, 1, 4),        3,
    (2, 3, 0, 4),           2,
    (2, 0, 0, 4),          -1,
;
my @Dead = [], ();
plan @Test ÷ 2 + @Dead;

multi task( @a where +* == 0 ) { die 'No room to move.' }
multi task( @a where +* == 1 -->Int) { 0 }
multi task( @a is copy -->Int) {
    my ($i, $nxt, $count) = 0, 0, 0;
    my $best = @a[0];
    @a = @a.pairs.Array.=map: {.key + .value};   # change rel. to direct ref
    return $count if $nxt == @a.end;
    loop {
        $count +=1;
        $nxt = @a[ [$i+1]..@a[$i]].max(:k).max +1;  # get idx of best reachable
        return $count if $nxt ≥ @a.end;             # done
        return Int if $nxt ≤ $i;                    # no progress
        $i = $nxt;                                  # done
    }
}

for @Dead -> @in {
    dies-ok {task(@in)}, "dies-ok <- @in.raku()" ;
}
for @Test -> @in, $exp {
    is task(@in) // -1, $exp, "$exp <- @in[]";
}

done-testing;

my @int = 1,2,3,0,0,1,2,0,7,4,3,3,2,1,0,1000;
say "\nInput: \@ints = @int[]\nOutput: {task(@int) // -1 }";

