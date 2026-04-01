#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
367-1 Task 1: Max Odd Binary
Submitted by: Mohammad Sajid Anwar
You are given a binary string that has at least one ‘1’.

Write a script to rearrange the bits in such a way that the resulting binary number is the maximum odd binary number and return the resulting binary string. The resulting string can have leading zeros.

=end comment

my @Test =
    # in          exp
    "1011",     "1101",
    "100",      "001",
    "111000",   "110001",
    "0101",     "1001",
    "1111",     "1111",

    "01",       "01",
    "1",        "1",
    '111',       '111',
    "101",       "101",

    "011",       "101",
    "100",       "001",
;
my @Dead =  '', '0', '000', '2';

plan +@Test + 2 × +@Dead;

# Binary-Not-Zero Str
subset BNZStr of Str where * ~~ / ^ <[01]>* 1 <[01]>* $/ ;

multi task-str( BNZStr:D() $a -->Str) {
    my $ones-ct = 0;
    my \len = $a.chars;
    $ones-ct += $a.substr( $_,1) for ^len;
    '1' x --$ones-ct  ~  '0' x $a.chars - ++$ones-ct  ~  '1';
}

multi task-ary( BNZStr:D() $a -->Str) {
    my @s = $a.comb.sort.reverse;
    @s.push: @s.shift;
    @s.join;
}

for @Test -> $in, $exp {
    is task-ary( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
    is task-str( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
for @Dead -> $in {
    dies-ok { task-ary( $in)}, "$in";
    dies-ok { task-str( $in)}, "$in";
}
done-testing;

use Bench;
my $b = Bench.new;

$b.cmpthese(1000, {
  short-Str  => { for @Test -> $t, $ { task-str $t; } },
  short-Ary  => { for @Test -> $t, $ { task-ary $t; } },
# do-nothing => { for @Test -> $t, $ {              } },  # about 3% overhead
});

my $str = "100";
say qq{\nInput: \$str = "$str"\nOutput: }, task-str $str;
