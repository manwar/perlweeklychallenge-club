#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ Δ
use v6.d;
use Test;

=begin comment
303-2: Delete and Earn          Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.
Write a script to return the maximum number of points you can earn by
applying the following operation some number of times.

Pick any ints[i] and delete it to earn ints[i] points.
Afterwards, you must delete every element equal to ints[i] - 1
and every element equal to ints[i] + 1.
Example 1
Input: @ints = (3, 4, 2)
Output: 6

Delete 4 to earn 4 points, consequently, 3 is also deleted.
Finally delete 2 to earn 2 points.
Example 2
Input: @ints = (2, 2, 3, 3, 3, 4)
Output: 9

Delete a 3 to earn 3 points. All 2's and 4's are also deleted too.
Delete a 3 again to earn 3 points.
Delete a 3 once more to earn 3 points.
=end comment

my @Test =
    6,  [3,4,2],
    9,  [2,2,3,3,3,4],
    0,  [],
    0,  [0],
    1,  [1],
    10, [10],
    52, [10,20,21,22],
    76, [10,20,22,23,24],
    77, [10,20,21,22,25],
    78, [10,20,21,22,26],
    79, [10,20,21,22,27],
    77, [10,20,21,22,25],
    0,  [-1],
    0,  [0,-1,-1, -2],
    2,  [1,1],
    2,  [1,2],
    3,  [1,1,1],
    15, [5,5,5,0,0,0],
    15, [5,5,5,-5,-5,-5],
    10, [4,5,5,6],
    17, [4,5,5,6,7],
    15, [5,5,5],
   447, [4,5,5,6,20,21,50,50,52,60,61,61,62,70,71,71],
  #1000009,  [2,0,2,0,3,3,3,4,0,1000000],
;
plan @Test ÷ 2;

sub get( %h, $int ) { %h{$int} // 0 }

multi task( @in where +* == 0 --> Int ) { 0 }
multi task( @in --> Int ) {
    my $b = Bag.new: @in;
    my @b-key = $b.keys.sort;

    my $delta = 0;
    my @total;
       @total[0] = 0;       # Preseed the zero-eth score…
       @total[1] = $b{1};   # … and the one-eth + the prior best score;

    my $window = ^3;    # Bag k-values < 1 can be ignored for no effect.

    while @$window.max ≤ @b-key[*-1] {
        my ( $l, $c, $r) = $window;
        @total[$r] =  @total[$l] + $r * $b{$r}  max  @total[$c];
        $window += 1;
    }
    return @total.tail;
}

for @Test -> $exp, @in {
    is task(    @in), $exp, "{$exp // $exp.^name} <- @in.raku()";
}
done-testing;

my @int = [2,0,2,0,3,3,3,4,0,1000];
say "\nInput: @ints = @int.raku()\nOutput: { task @int }";
