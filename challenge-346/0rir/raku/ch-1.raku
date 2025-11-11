#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
Task 1: Longest Parenthesis     Submitted by: Mohammad Sajid Anwar
You are given a string containing only ( and ).

Write a script to find the length of the longest valid parenthesis.
=end comment

my @Test =
    # in                exp
    '(()())',           6,
    ')()())',           4,
    '((()))()(((()',    8,
    '))))((()(',        2,
    '()(()',            2,
    '(',                0,
    ')(',               0,
;
plan +@Test ÷ 2;

grammar Parens {
    rule TOP       {  ^ .*? <parens> .*? $                     } 
    rule pairs     { '()'+                                     }
    rule contain   { '(' <pairs> ')'                           }
    rule recontain { '(' <contain>+ ')'                        }
    rule parens    { [ <pairs>+ | <contain>+ | <recontain>+ ]+ }
}

my regex valid { ^ <[)(]>+ $ }

sub task( Str:D $a where { $a ~~ /<valid>/ } -->Int) {
    return (my $m = Parens.parse: $a) ?? $m.hash<parens>.chars
                                       !! 0;
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my $str = '()(()';
say qq{\nInput: \$str = '$str'\nOutput: &task($str)};
=finish
