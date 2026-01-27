#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
May be edited:
357-1: Kaprekar Constant   Submitted by: Mohammad Sajid Anwar

Write a function that takes a 4-digit integer and returns how many iterations are required to reach Kaprekar’s constant (6174). For more information about Kaprekar's Constant please follow the wikipedia page.

=end comment

my \Kk = 6174;
my \Pass-ct = 7;
my \Digits = 4;

my @Test =
    # in  exp
    3524,  3,
    6174,  0,
    9998,  5,
    1001,  4,
    9000,  4,
    1111, Int,
;
plan +@Test ÷ 2;

sub task( Int:D(Any) $a is copy -->Int) {
    die 'too big' if $a.chars > Digits;
    my $pass = -1;
    while $pass < Pass-ct {
        ++$pass;
        return Int if $a == 0;
        return $pass if $a == Kk;
        if $a.chars < Digits { $a ~= '0' x Digits - $a.chars }
        $a = $a.comb.sort.reverse.join - $a.comb.sort.join;
    }
   return -1; 
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my $int = 9399;
say qq{\nInput: \$int = $int\nOutput: }, task( $int) // -1;

