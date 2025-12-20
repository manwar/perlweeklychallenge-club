#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
Task 1: Match String        Submitted by: Mohammad Sajid Anwar
You are given an array of strings.

Write a script to return all strings that are a substring of another word in the given array in the order they occur.
=end comment

my @Test =
    # @in   @exp
    <cat cats dog dogcat dogcat rat ratcatdogcat>,
            <cat dog dogcat rat>,
    <hello hell world wor ellow elloworld>,
            <hell world wor ellow>,
    <a aa aaa aaaa>,
            <a aa aaa>,
    <flower flow flight fl fli ig ght>,
            <flow fl fli ig ght>,
    <car carpet carpenter pet enter pen pent>,
            <car pet enter pen pent>,
;
plan +@Test ÷ 2;

sub task( @a) {
    my (@ret, %seen);
    for @a -> $w {
        next if %seen{$w} :exists;
        @ret.push( $w) if 0 < @a.grep: / [ .+ $w .+] | [ .+ $w ] | [ $w .+ ] / ;
        ++ %seen{$w};
    }
    return @ret.List;
}

for @Test -> @in, @exp {
    is task( @in), @exp, "{@exp // @exp.^name()} <- @in.raku()";
}
done-testing;

my @word = "hello", "hell", "world", "wor", "ellow", "elloworld";
say qq{\nInput: @words = ("@word.join('", "')")\nOutput: ("&task(@word).join('", ' )")};
