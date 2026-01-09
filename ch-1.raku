#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
May be edited.
355-1: Thousand Separator       Submitted by: Mohammad Sajid Anwar
You are given a positive integer, $int.

Write a script to add thousand separator, , and return as string.
=end comment

my @Test =
    # in     exp
    123,        "123",
    1234,       "1,234",
    1000000,    "1,000,000",
    1,          "1",
    12345,      "12,345",
;

plan +@Test ÷ 2;

sub task( Any:D $a, Str:D $sep = ',' -->Str:D) {
    my $_ = $a.flip;
    s:g/(...) <before .> /$0$sep/;
    .flip;
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my $int = 123456789012345;

say qq{\nInput: \$int = $int\nOutput: "}, task($int), '"';

