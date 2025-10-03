#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
Edited for space.
341-2: Reverse Prefix      Submitted by: Mohammad Sajid Anwar
You are given a string, $str and a character in the given string, $char.

Write a script to reverse the prefix upto the first occurrence of the given $char in the given string $str and return the new string.

Example 1
Input: $str = "programming", $char = "g"
Output: "gorpramming"
=end comment

my @Test =
    # in        char        exp
    "programming",  "g",    "gorpramming",
    "hello",        "h",    "hello",
    "abcdefghij",   "h",    "hgfedcbaij",
    "reverse",      "s",    "srevere",
    "perl",         "r",    "repl",
    "abcdefghij",   "j",    "jihgfedcba",
    "a",            "a",    "a",
    "ab",           "b",    "ba",
    "abc",          "a",    "abc",
    "abc",          "b",    "bac",
    "abc",          "c",    "cba",

;
plan +@Test ÷ 3;

sub task-ary( Str:D $str where *.chars ≥ 1, $char -->Str) {
    my @w = $str.comb;
    my $k = @w.first( :k, $char) // die qq{Error: char '$char' not in \$str};
    my $ret = @w[0..$k].reverse.join;
    return $ret if $k == @w.end;
    return $ret ~ @w[$k^..^@w].join;
}

sub task-str( Str:D $str where *.chars ≥ 1, $char -->Str) {
    my $k = $str.index( $char)   // die qq{Error: char '$char' not in \$str};
    my $ret = $str.substr(0..$k).flip;
    return $ret if $k == $str.chars - 1;
    return $ret ~ $str.substr($k^..^$str.chars);
}

for &task-ary, 'ARY', &task-str, 'STR'  -> &task, $name {
    for @Test -> $in, $char, $exp {
        is task( $in, $char), $exp,
                "{$exp // $exp.^name()} <- $char ∘∘ $in.raku() $name";
    }
}
done-testing;

my $str  = "raku";
my $char = "u";
say qq{\nInput: \$str = "$str", \$char = "$char"}
  ~ qq{\nOutput: "&task-str($str,$char)"};

use Bench;
my $b = Bench.new;
$b.cmpthese(10_000, {
    ary => { for @Test -> $in, $char, $junk { task-ary( $in, $char) }},
    str => { for @Test -> $in, $char, $junk { task-str( $in, $char) }},
});
