#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
265-1: 33% Appearance           Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.  Write a script to find an integer
in the given array that appeared 33% or more. If more than one found,
return the smallest. If none found then return undef.

Example 1
Input: @ints = (1,2,3,3,3,3,4,2)
Output: 3

1 appeared 1 times.
2 appeared 2 times.
3 appeared 4 times.

3 appeared 50% (>33%) in the given array.
Example 2
Input: @ints = (1,1)
Output: 1

1 appeared 2 times.

1 appeared 100% (>33%) in the given array.
Example 3
Input: @ints = (1,2,3)
Output: 1

1 appeared 1 times.
2 appeared 1 times.
3 appeared 1 times.

Since all three appeared 33.3% (>33%) in the given array.
We pick the smallest of all.

=end comment

my @Test =
    3,      (1,2,3,3,3,3,4,2),
    1,      (1,1),
    1,      (1,2,3),
    Int,    (1,2,3,4),
    1,      (4,1,4,1,4,1,4,1),
    1,      (4,1,4,1,4,1,4,4),
    1,      (4,1,4,1,4,1,4,9),
    1,      flat( (1,2,3) xx 333_331, 4 xx 7 ),
    1,      flat( (1,2,3) xx 33_330, 2, 2, 4 xx 7),
    Int,    flat( (1,2,3) xx 30, 4 xx 10 ),
    Int,    flat( (1,2,3) xx 30, 4 xx 9 ),
    3,      flat( (1,2,3) xx 30, 3 xx 10 ),
;
plan @Test ÷ 2;

sub over( @a, $min = 33 -->Int) {
    my $m = MixHash.new( @a);
    for $m.values -> $v is rw { $v ×= 100 ÷ @a.elems }      # percents
    my $ret = $m.sort( { .value, .key } ).first( *.value > $min);
    $ret.defined ?? $ret.key !! Int;
}

for @Test -> $exp, @in {
    is over( @in), $exp, ($exp // 'Int') ~ " <- @in.gist()";
}

done-testing;
my @int =  flat | (1,2,3) xx 32, 4, 2, 3,3 ;
say "\nInput: @int = @int[]\nOutput: ", over(@int);

exit;

