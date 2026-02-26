#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
361-Task 2: Find Celebrity
Submitted by: Mohammad Sajid Anwar
You are given a binary matrix (m x n).

Write a script to find the celebrity, return -1 when none found.

A celebrity is someone, everyone knows and knows nobody.

=end comment

my @Test =
   #  @in,  / $exp
   [ [0, 0, 0, 0, 1, 0],  # 0 knows 4,
     [0, 0, 0, 0, 1, 0],  # 1 knows 4,
     [0, 0, 0, 0, 1, 0],  # 2 knows 4,
     [0, 0, 0, 0, 1, 0],  # 3 knows 4,
     [0, 0, 0, 0, 0, 0],  # 4 knows NOBODY,
     [0, 0, 0, 0, 1, 0],  # 5 knows 4,
  ], 4,
  [ [0, 1, 0, 0],  # 0 knows 1,
    [0, 0, 1, 0],  # 1 knows 2,
    [0, 0, 0, 1],  # 2 knows 3,
    [1, 0, 0, 0]   # 3 knows 0,
  ], Int,
  [ [0, 0, 0, 0, 0],  # 0 knows NOBODY,
    [1, 0, 0, 0, 0],  # 1 knows 0,
    [1, 0, 0, 0, 0],  # 2 knows 0,
    [1, 0, 0, 0, 0],  # 3 knows 0,
    [1, 0, 0, 0, 0]   # 4 knows 0,
  ], 0,
  [ [0, 1, 0, 1, 0, 1],  # 0 knows 1, 3, 5,
    [1, 0, 1, 1, 0, 0],  # 1 knows 0, 2, 3,
    [0, 0, 0, 1, 1, 0],  # 2 knows 3, 4,
    [0, 0, 0, 0, 0, 0],  # 3 knows NOBODY,
    [0, 1, 0, 1, 0, 0],  # 4 knows 1, 3,
    [1, 0, 1, 1, 0, 0]   # 5 knows 0, 2, 3,
  ], 3,
  [ [0, 1, 1, 0],  # 0 knows 1 and 2,
    [1, 0, 1, 0],  # 1 knows 0 and 2,
    [0, 0, 0, 0],  # 2 knows NOBODY,
    [0, 0, 0, 0]   # 3 knows NOBODY,
  ], Int,
  [ [0, 0, 1, 1],  # 0 knows 2 and 3,
    [1, 0, 0, 0],  # 1 knows 0,
    [1, 1, 0, 1],  # 2 knows 0, 1 and 3,
    [1, 1, 0, 0]   # 3 knows 0 and 1,
  ], Int,

  [ [0, 1, 0], [0, 0, 0], [0, 1, 0], ], 1,
  [ [1, 1, 1], [0, 0, 0], [1, 1, 1], ], 1,
  [ [1, 1, 1], [1, 1, 1], [0, 0, 0], ], 2,
  [ [0, 0, 0], [1, 0, 1], [1, 0, 0], ], 0,
  [ [0, 0, 0], [1, 0, 1], [1, 0, 0], ], 0,
  [ [0, 0, 0], [0, 0, 1], [1, 0, 0], ], 0,
  [ [1, 0], [0, 0], ], 1,
  [ [0, 0], [1, 0], ], 0,
  [ [0, 0], [0, 0], ], Int,
  [ [1, 1], [0, 0], ], 1,
  [ [0, 1], [0, 1], ], Int,
;
plan +@Test ÷ 2;

say Int.^attributes;
 class BiInt is Int {
     has Int $.int handles *;
     submethod    TWEAK { die 'Value of bint must be 1 or 0' if $!int ≠ any 1,0; }

     method raku  { "BiInt(", $.values, ")" }
 }

my @x  = [[ BiInt.new( values => 1), BiInt.new( values => 1),],];
@x.push: [  BiInt.new( values => 0), BiInt.new( values => 1),];
@x.raku.say;

exit;
#subset BiInt of Int where * == any( 0, 1);

# Square array 
sub task( @a where ( @a == +@a[0] and @a.flat(:hammer).all ~~ BiInt) -->Int) {
    my @candi = (^@a).grep: { @a[$_].all ~~ 0 };
    when +@candi != 1 { return Int; }
    my $one-candi = @candi[0];
    my @zip = Array( [Z] @a);
    return $one-candi  if sum @zip[$one-candi] == @a;
    return Int;
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;
=finish

Input: @party = (
            [0, 0, 1, 1],  # 0 knows 2 and 3
            [1, 0, 0, 0],  # 1 knows 0
            [1, 1, 0, 1],  # 2 knows 0, 1 and 3
            [1, 1, 0, 0]   # 3 knows 0 and 1
      );
Output: -1


