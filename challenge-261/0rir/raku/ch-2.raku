#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use Test;

=begin comment
261-2: Multiply by Two              Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints and an integer $start.
Write a script to do the followings:

a) Look for $start in the array @ints, if found multiply the number by 2
b) If not found stop the process otherwise repeat
In the end return the final value.

Example 1
Input: @ints = (5,3,6,1,12) and $start = 3
Output: 24

Step 1: 3 is in the array so 3 x 2 = 6
Step 2: 6 is in the array so 6 x 2 = 12
Step 3: 12 is in the array so 12 x 2 = 24

24 is not found in the array so return 24.
Example 2
Input: @ints = (1,2,4,3) and $start = 1
Output: 8

Step 1: 1 is in the array so 1 x 2 = 2
Step 2: 2 is in the array so 2 x 2 = 4
Step 3: 4 is in the array so 4 x 2 = 8

8 is not found in the array so return 8.
Example 3
Input: @ints = (5,6,7) and $start = 2
Output: 2

2 is not found in the array so return 2.

=end comment

my @Test =
    # list       find  exp
     (),            3, Int,
     (1,),          0, 0,
     (1,),          3, 3,
     (5,3,6,1,12),  3, 24,
     (5,6,7),       2, 2,
     (1,2,4,3),     1, 8,
;
plan  @Test ÷ 3;

multi func( List $list where * ~~ Empty, Any:D $n ) { Int }
multi func( List $list, $n where * == 0) { 0 }
multi func( List $list, Any:D $n is copy) {
    return $n if not $n == $list.any;
    while so $n == $list.any {
        $n ×= 2;
    }
    return $n;
}

for @Test -> $list, $n, $exp {
    is func($list, $n), $exp, ($exp // $exp.^name) ~ " <- $n <- $list";
}

done-testing;
my $ints = (2,4,24,48,3,5,6,7,5,3,95,6,12,96);
my $start = 3;
say "\nInput: \$ints = $ints.raku() and \$start = $start
Output: &func($ints, $start)";


