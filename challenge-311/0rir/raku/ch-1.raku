#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
311-1: Upper Lower          Submitted by: Mohammad Sajid Anwar
You are given a string consists of english letters only.

Write a script to convert lower case to upper and upper case to lower in
the given string.

Example 1
Input: $str = "pERl"
Output: "PerL"
Example 2
Input: $str = "rakU"
Output: "RAKu"
Example 3
Input: $str = "PyThOn"
Output: "pYtHoN"
=end comment

my @Test =
    # r        l
    "pERl",     "PerL",
    "rakU",     "RAKu",
    "PyThOn",   "pYtHoN",
    "",         "",
;
my @Dead = Str, Cool;
plan @Test + @Dead;


constant $recase = [('a'..'z','A'..'Z').flat] => [('A'..'Z','a'..'z').flat];

only recase( Str:D $str is copy  -->Str) { $str.trans( $recase ) }

my &task := &recase;

for @Test -> $a, $b {
    is task( $b), $a, "{$a // $a.^name()} <- $b.raku()";
    is task( $a), $b, "{$b // $b.^name()} <- $a.raku()";
}
for @Dead -> $a {
    dies-ok { task $a }, 'dies on not DEFINITE' ;
}
done-testing;

my $str = "1) python IS A snake.";

say "\nInput: \$str = \"$str\"\nOutput: \"{task $str}\"";
