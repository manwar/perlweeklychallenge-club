#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
268-2: Number Game       Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints, with even number of elements.

Write a script to create a new array made up of elements of the given array.
Pick the two smallest integers and add it to new array in decreasing order
i.e. high to low. Keep doing until the given array is empty.

Example 1
Input: @ints = (2, 5, 3, 4)
Output: (3, 2, 5, 4)

Round 1: we picked (2, 3) and push it to the new array (3, 2)
Round 2: we picked the remaining (4, 5) and push it to the new array (5, 4)
Example 2
Input: @ints = (9, 4, 1, 3, 6, 4, 6, 1)
Output: (1, 1, 4, 3, 6, 4, 9, 6)
Example 3
Input: @ints = (1, 2, 2, 3)
Output: (2, 1, 3, 2)
=end comment

my @Test =
    # in                                out
    (2, 5, 3, 4),                   (3,2, 5,4),
    (9, 4, 1, 3, 6, 4, 6, 1),       (1,1, 4,3, 6,4, 9,6),
    (1, 2, 2, 3),                   (2,1, 3,2),
    (),                             (),
    (0,),                           (0,),
    (0, 0),                         (0,0),
    (0, 0, 0),                      (0,0, 0),
    (9, 4, 1, 3, 6, 4, 6, 1, 0),    (1,0, 3,1, 4,4, 6,6, 9),
    (0,9, 4, 1, 3, 6, 4, 6, 1, 0),  (0,0, 1,1, 4,3, 6,4, 9,6),
;

plan @Test ÷ 2;

sub func( @a is copy ) {
    @a.=sort;
    my @ret;   # using two shift as Opt just two ptr moves but not tested
    while @a > 1 {  @ret.append: (@a.shift, @a.shift).sort.reverse }
    if @a {         @ret.append: @a.pop }
    @ret;
}

for @Test -> @in, @out {
    func( @in);
}
for @Test -> @in, @exp {
    is func(@in), @exp, "@exp[] <- @in.sort()";
}
done-testing;
