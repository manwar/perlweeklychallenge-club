#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
270-2: Equalize Array          Submitted by: Mohammad Sajid Anwar
You are give an array of integers, @ints and two integers, $x and $y.

Write a script to execute one of the two options:

Level 1:
Pick an index i of the given array and do $ints[i] += 1

Level 2:
Pick two different indices i,j and do $ints[i] +=1 and $ints[j] += 1.
You are allowed to perform as many levels as you want to make every elements in the given array equal. There is cost attach for each level, for Level 1, the cost is $x and $y for Level 2.

In the end return the minimum cost to get the work done.

Example 1
Input: @ints = (4, 1), $x = 3 and $y = 2
Output: 9

Level 1: i=1, so $ints[1] += 1.
@ints = (4, 2)

Level 1: i=1, so $ints[1] += 1.
@ints = (4, 3)

Level 1: i=1, so $ints[1] += 1.
@ints = (4, 4)

We performed operation Level 1, 3 times.
So the total cost would be 3 x $x => 3 x 3 => 9
Example 2
Input: @ints = (2, 3, 3, 3, 5), $x = 2 and $y = 1
Output: 6

Level 2: i=0, j=1, so $ints[0] += 1 and $ints[1] += 1
@ints = (3, 4, 3, 3, 5)

Level 2: i=0, j=2, so $ints[0] += 1 and $ints[2] += 1
@ints = (4, 4, 4, 3, 5)

Level 2: i=0, j=3, so $ints[0] += 1 and $ints[3] += 1
@ints = (5, 4, 4, 4, 5)

Level 2: i=1, j=2, so $ints[1] += 1 and $ints[2] += 1
@ints = (5, 5, 5, 4, 5)

Level 1: i=3, so $ints[3] += 1
@ints = (5, 5, 5, 5, 5)

We performed operation Level 1, 1 time and Level 2, 4 times.
So the total cost would be (1 x $x) + (4 x $y) => (1 x 2) + (4 x 1) => 6
=end comment

my @Test =
  # exp     $x      $y   @int
     Int,    8,      8,  (),
     Int,    8,     -8,  [,],
     Int,   -8,      8,  (),
     Int,   -8,     -8,  [,],

     0,      0,      0,  (2,3,3,3,5),
     0,      0,      1,  (2,3,3,3,5),
    -4,      0,     -1,  (2,3,3,3,5),

     1,      1,      0,  (2,3,3,3,5),
     9,      1,      2,  (2,3,3,3,5),
     9,      1,      3,  (2,3,3,3,5),
     6,      2,      1,  (2,3,3,3,5),
    23,      3,      5,  (2,3,3,3,5),
    24,      4,      5,  (2,3,3,3,5),
    29,      5,      6,  (2,3,3,3,5),
     7,      2,      1,  (1,2,3,3,5),
    11,      1,      2,  (1,2,3,3,5),
     5,      1,      1,  (2,3,3,3,5),
    14,      2,      3,  (2,3,3,3,5),
     9,      3,      2,  (4,1),
    -9,     -1,      0,  (2,3,3,3,5),
   -18,     -2,     -1,  (2,3,3,3,5),
   -18,     -2,     -3,  (2,3,3,3,5),
    -9,     -1,      1,  (2,3,3,3,5),
    -9,     -1,      1,  (2,3,3,3,5),
   -22,     -2,     -5,  (2,3,3,3,5),
;
plan @Test ÷ 2;

subset Nat of Int where * > 0;
subset Neg of Int where * < 0;

multi task( @int where * ~~ [],
                       $x,      $y                  ) { Int               }

multi task( @int,       0,      $y where * ≥ 0      ) { 0                 }
multi task( @int,       0,  Nat $y                  ) { 0                 }
multi task( @int,       0,  Neg $y                  ) { Yx( @int,  0, $y) }
multi task( @int,  Nat $x,       0,                 ) { Yx( @int, $x,  0) }
multi task( @int,  Neg $x,       0                  ) { Xx( @int, $x    ) }

multi task( @int,  Nat $x,      $y where * ≤ $x × 2 ) { Yx( @int, $x, $y) }
multi task( @int,  Nat $x,  Nat $y where * > $x × 2 ) { Xx( @int, $x    ) }

multi task( @int,  Neg $x,      $y where * ≥ $x × 2 ) { Xx( @int, $x, $y) }
multi task( @int,  Neg $x,      $y where * < $x × 2 ) { Yx( @int, $x, $y) }

only task-B( @int, $x, $y --> Int) {

    if ( @int ~~ [,] ) {            return Int }

    if $x == 0 {
        if $y ~~ Nat  {             return 0 }
        if $y ~~ Neg  {             return Yx( @int, $x , $y) }
        if $y == 0    {             return 0 }
    }

    if $x ~~ Nat {
        if $y ~~ Nat {
            if $y ≥ $x × 2 {        return Xx @int, $x, $y; }
            if $y < $x × 2 {        return Yx @int, $x, $y; }
        }
        if $y !~~ Neg {             return Yx @int, $x, $y; }
    }
   if $x ~~ Neg {
            if $y ~~ Nat {          return Xx( @int, $x , $y) }
            if $y ~~ Neg {
                if $y ≥ $x × 2 {    return Xx( @int, $x , $y) 
                } else {            return Yx( @int, $x , $y) }
            }
            if $y == 0   {          return Xx( @int, $x , $y) }
   }
   die "Not expected: x: $x  y: $y,   @int.raku()";
}

# Prefer changing one value at a time.  So all are changed one by one.
sub Xx( @int, $x, $y? ) { @int.map( ( $ = @int.max) - * ).sum × $x }

# Prefer changing 2 values at a time).  So all but one are changed by pairs.
sub Yx( @int, $x, $y) { 
    my @a = @int.Array.sort.reverse;    # avoid i & j for i and i+1.
    my $mx = @a.shift;
    my $cost;
    for 0..^@a.end -> \i {
        while @a[i] < $mx {
            ++ @a[i]; 
            ++ @a[i +1];
            $cost += $y;
        }
    }
    while @a[*-1] < $mx {
       ++ @a[*-1];
       $cost +=$x;
   }
   $cost
}

for @Test -> $exp, $x, $y, @int {
    is task(   @int, $x, $y), $exp, ($exp // "Int") ~ " <- $x ∘ $y ∘ @int.raku()";
    is task-B( @int, $x, $y), $exp, ($exp // "Int") ~ " <- $x ∘ $y ∘ @int.raku()";
}

done-testing;
