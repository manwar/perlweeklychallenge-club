#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»
use v6.d;
use Test;

=begin comment
199-2: Good Triplets            Submitted by: Mohammad S Anwar
Given an array of integers, @array and three integers $x,$y,$z,
find the total of Good Triplets in the given array.

Array[i], array[j], and array[k] are a Good Triplet if they satisfies
the following conditions:

a) 0 <= i < j < k <= n (size of given array)
b) abs(array[i] - array[j]) <= x
c) abs(array[j] - array[k]) <= y
d) abs(array[i] - array[k]) <= z

Example 1
Input: @array = (3,0,1,1,9,7) and $x = 7, $y = 2, $z = 3
Output: 4

Good Triplets are as below:
(3,0,1) where (i=0, j=1, k=2)
(3,0,1) where (i=0, j=1, k=3)
(3,1,1) where (i=0, j=2, k=3)
(0,1,1) where (i=1, j=2, k=3)
Example 2
Input: @array = (1,1,2,2,3) and $x = 0, $y = 0, $z = 1
Output: 0
=end comment

sub ct-good-triplets( @array, :$x, :$y, :$z --> Int ) {
    my $return = 0;
    for 0..@array.end -> $i {
        for $i^..@array.end -> $j {
            for $j^..@array.end -> $k {
                if      abs(@array[$i] - @array[$j]) <= $x
                    and abs(@array[$j] - @array[$k]) <= $y
                    and abs(@array[$i] - @array[$k]) <= $z {
                    ++$return;
    }   }   }   }
    $return;
}

multi MAIN() {
    my @Test =
        { array => Empty,               x => 7, y => 2, z => 3, exp => 0 },
        { array => [3,0,1,1,9,7],       x => 7, y => 2, z => 3, exp => 4 },
        { array => [1,1,2,2,3],         x => 0, y => 0, z => 1, exp => 0 },

        { array => [5,3,3],             x => 1, y => 1, z => 2, exp => 0 },
        { array => [4,3,3],             x => 1, y => 1, z => 2, exp => 1 },
        { array => [3,3,3],             x => 1, y => 1, z => 2, exp => 1 },
        { array => [2,3,3],             x => 1, y => 1, z => 2, exp => 1 },
        { array => [1,3,3],             x => 1, y => 1, z => 2, exp => 0 },
        { array => [0,3,3],             x => 1, y => 1, z => 2, exp => 0 },

        { array => [3,5,3],             x => 1, y => 1, z => 2, exp => 0 },
        { array => [3,4,3],             x => 1, y => 1, z => 2, exp => 1 },
        { array => [3,3,3],             x => 1, y => 1, z => 2, exp => 1 },
        { array => [3,2,3],             x => 1, y => 1, z => 2, exp => 1 },
        { array => [3,1,3],             x => 1, y => 1, z => 2, exp => 0 },
        { array => [3,0,3],             x => 1, y => 1, z => 2, exp => 0 },

        { array => [3,3,5],             x => 1, y => 1, z => 2, exp => 0 },
        { array => [3,3,4],             x => 1, y => 1, z => 2, exp => 1 },
        { array => [3,3,3],             x => 1, y => 1, z => 2, exp => 1 },
        { array => [3,3,2],             x => 1, y => 1, z => 2, exp => 1 },
        { array => [3,3,1],             x => 1, y => 1, z => 2, exp => 0 },
        { array => [3,3,0],             x => 1, y => 1, z => 2, exp => 0 },

        { array => [1,2,3],             x => 1, y => 0, z => 3, exp => 0 },
        { array => [1],                 x => 7, y => 2, z => 3, exp => 0 },
        { array => [1,2],               x => 7, y => 2, z => 3, exp => 0 },
        { array => [3,0,1,1,9,7],       x => 7, y => 2, z => 3, exp => 4 },
        { array => [1,1,2,2,3],         x => 0, y => 0, z => 1, exp => 0 },
        { array => [-3,0,-1,-1,-9,-7],  x => -7, y => -2, z => -3, exp => 0 },
        { array => [-3,0,-1,-1,-9,-7],  x => 7, y => 2, z => 3, exp => 4 },
        { array => [-1,-1,-2,-2,-3],    x => 0, y => 0, z => 1, exp => 0 },
    ;

    plan +@Test;
    for @Test -> %t {
        is  ct-good-triplets( %t<array>, :x(%t<x>), :y(%t<y>), :z(%t<z>) ),
            %t<exp>, "%t<exp> <-- %t<x> %t<y> %t<z> %t<array>.raku()";
    }
    done-testing;

    my @array = (3,0,1,1,9,7);
    my ($x,$y,$z)  = 7, 2,3; 
    say "\nInput: \@array = @array.raku() and \$x = $x, \$y = $y, \$z = $z\n"
      ~ "Output: ", ct-good-triplets( @array, :$x, :$y, :$z);
}
