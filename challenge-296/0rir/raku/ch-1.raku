#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
296-1: String Compression       Submitted by: Mohammad Sajid Anwar
You are given a string of alphabetic characters, $chars.

Write a script to compress the string with run-length encoding, as shown in the examples.

A compressed unit can be either a single character or a count followed by a character.

BONUS: Write a decompression function.

Example 1
Input: $chars = "abbc"
Output: "a2bc"
Example 2
Input: $chars = "aaabccc"
Output: "3ab3c"
Example 3
Input: $chars = "abcc"
Output: "ab2c"
=end comment

my @Test =
    # in            exp
     "",            "",
     'a',           'a',
     "a" x 2,      "2a",
     "abbc",        "a2bc", 
     "aaabccc",     "3ab3c", 
     "abcc",        "ab2c",
     "aabbcc",      "2a2b2c",
     'b' ~ "a" x 101 ~ 'bbbe', "b101a3be",
     ;
plan 2 × @Test ÷ 2;

multi task(Str:D $a where *.chars < 2) { $a }
multi task(Str:D $a -->Str) {
   my $m = $/ if $a ~~ m:g/( (.) $0*)/;
   (    ($m.list».Str)
       .map( { .chars > 1 ?? .chars ~ .substr(0,1) !! .self }  )
       .join;
   )
}

multi untask(Str:D $a where *.chars < 2) { $a }
multi untask(Str:D $a -->Str) {
    my @a = $a.comb;
    my $ret;
    while @a {
        given my $c = @a.shift {
            when / <:L> / {
                $ret ~= $c;
            }
            when / <:Nd> / {
                my $n = $c;
                while @a[0] ~~ / <:Nd> / {
                    $n ~= @a.shift;
                }
                my $l = @a.shift;
                $ret ~= $l x $n;
            }
        }
    }
    $ret;
}


for @Test -> $in, $exp {
    is   task($in), $exp, "  task $exp <- $in";
    is untask($exp), $in, "untask $in <- $exp";
}

done-testing;

my $chars = "aaabccc";
my $output = task $chars;

say "Input: \$chars = $chars\nOutput: $output\nReput: {untask $output}";



