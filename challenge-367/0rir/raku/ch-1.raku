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
    "",         '',
    "1",        "1",
    '0',        '0',
    '000',       '000',
    '111',       '111',
    "101",       "101",

    "011",       "101",
    "100",       "001",
;
plan +@Test;

multi task-str( Str:D() $a where *.chars ≤ 1 ) { $a }
multi task-str( Str:D() $a -->Str) {
    my $ones-ct = 0;
    my \len = $a.chars;
    for ^len {
        $ones-ct += $a.substr( $_,1) eq '1'  ?? 1 !! 0
    }
    given $ones-ct -> $c {
        when $c == 0 or $c == len  { $a }
        when $c == 1    { '0' x len -1 ~ '1' }
        default {
            '1' x --$ones-ct  ~  '0' x $a.chars - ++$ones-ct  ~  '1';
        }
    }
}

multi task-ary( Str:D() $a where *.chars ≤ 1 ) { $a }
multi task-ary( Str:D() $a -->Str) {
    my @s = $a.comb.sort.reverse;
    return @s.join if @s[0] eq '0' or @s[*-1] eq '1';    # all bits same
    @s = do { @s.push: @s.shift };
    @s.join if @s[0] eq '0' or @s[*-1] eq '1';
}

for @Test -> $in, $exp {
    is task-ary( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
    is task-str( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

use Bench;
my $b = Bench.new;

$b.cmpthese(1000, {
  short-Str  => { for @Test -> $t, $ { task-str $t; } },
  short-Ary  => { for @Test -> $t, $ { task-ary $t; } },
  semi-colon    => { for @Test -> $t, $ { ;            } },
#  long-Str => { for @Test -> $t, $ { task-ary $t x 100; } },  # longer inputs …
#  long-Ary => { for @Test -> $t, $ { task-ary $t x 100; } },  # … remove the time diff
});


my $str = "100";

say qq{\nInput: \$str = "$str"\nOutput: }, task-str $str;
