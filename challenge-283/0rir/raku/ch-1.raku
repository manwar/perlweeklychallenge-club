#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment

283-1: Unique Number            Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints, where every element appears
more than once except one element.

Write a script to find the one element that appears exactly one time.

Example 1
Input: @ints = (3, 3, 1)
Output: 1
Example 2
Input: @ints = (3, 2, 4, 2, 4)
Output: 3
Example 3
Input: @ints = (1)
Output: 1
Example 4
Input: @ints = (4, 3, 1, 1, 1, 4)
Output: 3
=end comment

my @Test =
        # in                exp
     (3, 3, 1),             1,
     (3, 2, 4, 2, 4),       3,
     (1,),                  1,
     [4, 3, 1, 1, 1, 4],    3,
;

my @Dead =  (),     [,],       [2,2], ;

plan @Test + @Dead;

sub task( List $a) { $a.Bag.first( { .value == 1 }).key; }

sub task-w-validate( List $a) {
    my $l = $a.Bag.List;                        # stabilize sequencing
    my @k = $l.grep( *.value == 1, :k  );
    die 'Invalid input.' if @k ~~ Empty or @k > 1;
    $l[@k[0]].key;
}

for @Test -> $in, $exp {
    is task($in), $exp, "$exp <- $in.raku()";
    is task-w-validate($in), $exp, "$exp <- $in.raku() valid";
}
for @Dead -> $dead {
    dies-ok { task-w-validate($dead)}, " dead <- $dead.raku()";
}

done-testing;

my @int = (1,2,3,4,5,6,7,8,9,10,11,12,12,11,10,9,8,7,6,5,4,3,2);
say "\nInput: \@ints = @int[]\nOutput: ", task( @int);

