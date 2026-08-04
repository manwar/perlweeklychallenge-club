#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
384-1: Base N           Submitted by: Mohammad Sajid Anwar

You are given a number and a base integer.
Write a script to convert the given number to the given base integer.

=end comment

my @Test =
 #     value    base        exp
          42,      2,       "101010",
     15642094,    16,       "EEADEE",
          493,     8,       "755",
      2228519,    36,       "1BRJB",
    123456789,    64,       "7MyqL",
           50,     5,       "200",
          -62,    64,       '-▫',
          -63,    64,       '-⬜',
          -64,    64,       '-10',
            0,    64,       '0',
           10,    64,       'A',
           36,    64,       'a',
           62,    64,       '▫',
           63,    64,       '⬜',
           64,    64,       '10',
           65,    64,       '11',
          128,    64,       '20',
        15**59,   64,       '5hhrHPrqK9JpByC7TXgk▫TTHsiRws9GzDBtCoIl',
;
plan +@Test ÷ 3;

my @bigit = flat '0' … '9', 'A' … 'Z', 'a' … 'z', '▫','⬜';

multi task( Mu:D(Int) $a is copy where * < 0,
            Mu:D(Int) $base where * > 1  -->Str:D)  {
    return '-' ~ task $a.abs, $base
}

multi task( Mu:D(Int) $a is copy, Mu:D(Int) $base where * > 1  -->Str:D)  {
    my $ret = '';
    while $a ≥ $base {
        my $r = $a % $base;
        $a div= $base;
        $ret =  $ret R~ @bigit[$r];
    }
    $ret R~ @bigit[$a];
}

for @Test -> $val, $base, $exp {
    is task( $val, $base), $exp, "$exp <- $val ∘∘ $base";
}
done-testing;

my $num  = -64**2 +2;
my $base = 64;

say qq{\nInput: \$num = $num, \$base = $base\nOutput: }, task $num,$base;
