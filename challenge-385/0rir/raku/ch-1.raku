#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
385-Task 1: Uncommon Words      Submitted by: Mohammad Sajid Anwar

You are given two sentences.
Write a script to return list of all uncommon words, order is not important.
=end comment

my @Test =
    "apple banana apple",  "banana orange",         ("orange"),
    "cat dog",             "bird fish",      
                                            ("cat", "dog", "bird", "fish"),
    "the quick brown fox", "the quick",              ("brown", "fox"),
    "hello",               "hello",                  (),
    "blue blue red",       "red green green yellow", ("yellow"),
;
plan +@Test ÷ 3;

#  an ordered  result
sub task-order( Any:D(Str) $a, Any:D(Str) $b -->List:D) {
    my @ary = ($a ~ ' ' ~ $b).split( / \s+ / ).Array;
    my $count = @ary.Bag;
    do for @ary ->  $v {
        next unless $count{$v} == 1;
        $v;
    }
}

sub task( Any:D(Str) $a, Any:D(Str) $b -->List:D) {
    my %h = ($a ~ ' ' ~ $b).split( / \s+ / ).BagHash;
    do for %h.kv ->  $k, $v {
        next unless $v == 1;
        $k;
    }
}

for @Test -> $a, $b, $exp {
    is task( $a, $b).sort, $exp.sort, "$exp.raku() <- $a ∘∘ $b";
    is task-order( $a, $b), $exp, "$exp.raku() <- $a ∘∘ $b";
}
done-testing;

my $sentence1 = "blue blue red";
my $sentence2 = "red green green yellow";

say qq{\nInput: \$sentence1 = "$sentence1"
        \$sentence2 = "$sentence2"
Output: &task( $sentence1, $sentence2).raku()}

