#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
330-1: Clear Digits         Submitted by: Mohammad Sajid Anwar
You are given a string containing only lower case English letters and digits.

Write a script to remove all digits by removing the first digit and the closest non-digit character to its left.


Example 1
Input: $str = "cab12"
Output: "c"

Round 1: remove "1" then "b" => "ca2"
Round 2: remove "2" then "a" => "c"

Example 2
Input: $str = "xy99"
Output: ""

Round 1: remove "9" then "y" => "x9"
Round 2: remove "9" then "x" => ""

Example 3
Input: $str = "pa1erl"
Output: "perl"
=end comment

my @Test =
    "",                                     "",
    "pa1erl",                               "perl",
    "ca11b",                                "b",
    'a',                                    'a',
    "cab12",                                "c",
    "cab12cd12",                            "c",
    "xy99",                                 "",
    "abc123abc123",                         "",
    "a1a1ab12ab12abc123abc123",             "",
    "a1xa1ab12ab12xabc123xabc123",          "xxx",
    'a' x 100 ~ 'b1',                       'a' x 100,
    "cab12" x 100,                          "c" x 100,
    '1b',                                   '1b',
    '1111111111',                           '1111111111',
;

=begin spec
    It is not clear whether a un-paired digit should be deleted.
=end spec

plan +@Test ÷ 2;

constant \OoB = '.';            #  an out of band value
my \Nd = regex { ^ <:Nd> $ }
my \L  = regex { ^ <:L>  $ }
my @removee;                    # deletable chars by key

# Return the index of a digit's partner or an Int type object.
sub partner( @a, Int $idx --> Int){
    quietly @a[0...$idx].first( :end, :k, * ~~ L)       # undef
}

# Return index of the next digit or an Int type object.
sub seekn( @a, Int $head --> Int) {
    my $ret = quietly @a[$head…@a.end].first: :k, * ~~ Nd;      # undefines
    $ret.defined ?? $ret + $head !! Int;
}

multi task( "" --> "") {}
multi task( Str:D $s where * ~~ /^L+ $/ , Bool :$req --> Str) { $s }
multi task( Str:D $s where * ~~ /^Nd+ $/, Bool :$req -->Str ) {
    $req ?? '' !! $s
}
multi task( Str:D $s --> Str ) {
    my @a = $s.comb;
    my $i = -1;
    while $i < @a {
        ++$i;
        my $idx-n = seekn( @a, $i );
        last unless $idx-n.defined;
        my $idx-l = partner( @a, $idx-n);
        if $idx-l.defined {
            @a[$idx-l, $idx-n] = OoB xx 2;
        }
        $i = $idx-n;
    }
    (@a.=grep: * !~~ OoB).join;
}

for @Test -> $in, $exp {
    is task( $in), $exp,                     "{$exp // $exp.^name()} <- $in.raku()";
    #    is task( $in, :req), $exp-req, "{$exp-req // $exp-req.^name()} <- $in.raku()";
}
done-testing;
my $str = "1axy9999";

say qq{Input: \$str = "$str"\nOutput: "}, task($str), '"';
