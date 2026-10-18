#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
May be edited for no good reason:
395-1: Complex Number      Submitted by: Mohammad Sajid Anwar
You are given two complex numbers as string.
Write a script to return the multiplication of the given complex numbers.
Using the formula: (a + bi) x (c + di) = (ac - bd) + (ad + bc)i
=end comment

my @Test =
    # arg1          arg2            exp
    "1+1i",         "1+1i",         "0+2i",
    "1+(-1)i",      "1+(-1)i",      "0-2i",     # was "0+(-2)i",
    "0+3i",         "0+4i",         "-12+0i",
    "3+4i",         "3+(-4)i",      "25+0i",
    "50+(-20)i",    "-10+30i",      "100+1700i",
;
plan @Test ÷ 3;

my token exorcise  { ^ <[ . 0..9 i E e + ) (- ]>+ $ }

subset Pure of Str where so quietly * ~~ <exorcise>;
    
sub task ( Pure() $a, Pure() $b -->Complex) is export {
     [×] ( do for $a, $b { my $res = EVAL $_; } );
}

for @Test -> $a, $b, $exp {
    is task( $a, $b), $exp, "$exp <- $a ∘∘ $b";
}
done-testing;

my $num1 = "50+(-20)i";
my $num2 = "-10+30i";

say qq{\nInput: \$num1 = "$num1", \$num2 = "$num2"\nOutput: "},
        task( $num1, $num2),
        '"';
