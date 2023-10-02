#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
Task 2: Count Words
Submitted by: Mohammad S Anwar
You are given an array of words made up of alphabetic characters and a prefix.

Write a script to return the count of words that starts with the given prefix.

Example 1
Input: @words  = ("pay", "attention", "practice", "attend")
       $prefix = "at"
Ouput: 2

Two words "attention" and "attend" starts with the given prefix "at".
Example 2
Input: @words  = ("janet", "julia", "java", "javascript")
       $prefix = "ja"
Ouput: 3

Three words "janet", "java" and "javascripr" starts with the given prefix "ja".
=end comment

my @Test =
    ("pay", "attention", "practice", "attend"),     "",      4,
    ("pay", "attention", "practice", "attend"),     "at",    2,
    ("pay", "attention", "practice", "attend"),     "at",    2,
    ("janet", "julia",   "java", "javascript"),     "j",     4,
    ("janet", "julia",   "java", "javascript"),     "ja",    3,
    ("janet", "julia",   "java", "javascript"),     "jav",   2,
    ("janet", "julia",   "java", "javascript"),     "ju",    1,
    ("janet", "julia",   "java", "javascript"),     "je",    0,
;
plan @Test ÷ 3;

sub func( @w, $p --> Int) {
    @w.grep( * ~~ / ^ $p /, :k ).elems;
}

for @Test -> @in, $pref, $exp {
    is func(@in, $pref), $exp,
            "$exp <- "~ $pref.fmt ~ "∘\t@in.raku()";
}
done-testing;

my @word = ("pay", "attention", "practice", "attend");
my $prefix = 'pa';
say "\nInput: @words  = @word[]\n\$prefix = $prefix\nOuput: ",
        func(@word, $prefix);
exit;

