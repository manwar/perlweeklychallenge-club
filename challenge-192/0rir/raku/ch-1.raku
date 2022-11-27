#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");
use Test;

=begin comment
192-1: Binary Flip             Submitted by: Mohammad S Anwar
Given a positive integer, $n, find the binary flip; which is the bit-wise
'not' of the bits expressing $n.  For example  5 --> 101 --> 010 --> 2.

Input: $n = 5
Output: 2
=end comment

sub binary-flip( Any $n where * > 0 --> Int) {
    $n.base(2).trans( <0 1> =>  <1 0>).parse-base(2).Int;
}
multi MAIN( Int $pos-integer ) {
    say "Input: \$n = $pos-integer\n"
       ~"Output: ", binary-flip($pos-integer);
}
multi MAIN ( 'test' ) {
    my @Test =  32 => 31, 31 =>  0, 30 =>  1, 29 =>  2, 28 =>  3, 27 =>  4,
                26 =>  5, 25 =>  6, 24 =>  7, 23 =>  8, 22 =>  9, 21 => 10,
                20 => 11, 19 => 12, 18 => 13, 17 => 14, 16 => 15, 15 =>  0,
                14 =>  1, 13 =>  2, 12 =>  3, 11 =>  4, 10 =>  5,  9 =>  6,
                 8 =>  7,  7 =>  0,  6 =>  1,  5 =>  2,  4 =>  3,  3 =>  0,
                 2 =>  1,
            2⁶⁴ +1 => 2⁶⁴ -2,   2⁶⁴    => 2⁶⁴ -1,
            2⁶⁴ -8 => 7     ,   2⁶⁴ -2 => 1     ,
           2¹⁰²⁴-7  => 6    ,  2¹⁰²⁴-4 => 3     ,
           2¹⁰²⁴-2  => 1    ,
    ;
    for @Test -> $t {
        is  binary-flip($t.key), $t.value, "binary-flip($t.key()) --> $t.value()"
    }
    done-testing;
}

