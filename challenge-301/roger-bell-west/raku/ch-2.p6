#! /usr/bin/raku

use Test;

plan 2;

is(hammingdistance([4, 14, 2]), 6, 'example 1');
is(hammingdistance([4, 14, 4]), 4, 'example 2');

sub popcount64($x0) {
    constant $M1  = 0x5555555555555555;
    constant $M2  = 0x3333333333333333;
    constant $M4  = 0x0f0f0f0f0f0f0f0f;
    constant $H01 = 0x0101010101010101;
    my $x = $x0;
    $x -= ($x +> 1) +& $M1;
    $x = ($x +& $M2) + (($x +> 2) +& $M2);
    $x = ($x + ($x +> 4)) +& $M4;
    return ($x * $H01) +> 56;
}

sub hammingdistance(@a) {
    my $t = 0;
    for 0 .. @a.end - 1 -> $i {
        for  $i + 1 .. @a.end -> $j {
            $t += popcount64(@a[$i] +^ @a[$j]);
        }
    }
    $t
}
