#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
268-1 Task 1: Magic Number      Submitted by: Mohammad Sajid Anwar
You are given two arrays of integers of same size, @x and @y.

Write a script to find the magic number that when added to each
elements of one of the array gives the second array. Elements order
is not important.

Example 1
Input: @x = (3, 7, 5)
       @y = (9, 5, 7)
Output: 2

The magic number is 2.
@x = (3, 7, 5)
   +  2  2  2
@y = (5, 9, 7)
Example 2
Input: @x = (1, 2, 1)
       @y = (5, 4, 4)
Output: 3

The magic number is 3.
@x = (1, 2, 1)
   +  3  3  3
@y = (5, 4, 4)
Example 3
Input: @x = (2)
       @y = (5)
Output: 3

=end comment

my @Test =
    # ary    ary      magic_num
    (3, 7, 5), (9, 5, 7), 2,
    (1, 2, 1), (5, 4, 4), 3,
    (2,), (5,), 3,
    (2,5), (2,5), 0,
    (2,5), (1,9), Int,
    (),    (),    Int,
;
my @Die =
    (1,0), (2,),
    (),    (1,2),
    (1,2), (),
;
plan @Test ÷ 3 + @Die ÷ 2;

multi func( @a where * ~~ [], @b where * ~~ [] --> Int ) { Int }
multi func( @a, @b where +* == +@a --> Int) {
    my @candi = (@a.sort [Z-] @b.sort);
    return (@candi.all == @candi[0])
           ?? @candi[0].Int.abs
           !! Int;
}

for @Test -> @a, @b, $exp {
    is func(@a, @b), $exp, ($exp // "(Int)") ~ " ~~\t @a[] <=- @b[]";
}

for @Die -> @a, @b {
    dies-ok { func(@a, @b) }, "die ~~\t @a[] <=- @b[]";
}
done-testing;

exit;

