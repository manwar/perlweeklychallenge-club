#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
INIT $*RAT-OVERFLOW = FatRat;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
May be edited for space.
Task 1: Missing Letter
Submitted by: Reinier Maliepaard
You are given a sequence of 5 lowercase letters, with one letter replaced by ‘?’. Each letter maps to its position in the alphabet (‘a = 1’, ‘b = 2’, …, ‘z = 26’). The sequence follows a repeating pattern of step sizes between consecutive letters. The pattern is either a constant step (e.g., ‘+2, +2, +2, +2’) or a simple alternating pattern of two distinct steps (e.g., ‘+2, +3, +2, +3’).

=end comment

my @Test =
    # in           exp
    <a c ? g i>,   'e',
    <a d ? j m>,   'g',
    <a e ? m q>,   'i',
    <a c f ? k>,   'h',
    <b e g ? l>,   'j',

    <? c d e f>,   'b',
    <? b c d e>,   'a',
    <a ? c d e>,   'b',
    <a b ? d e>,   'c',
    <a b c ? e>,   'd',
    <a b c d ?>,   'e',
    <a ? d f g>,   'c',
    <a c ? f g>,   'd',
    <a c d ? g>,   'f',
    <a c d f ?>,   'g',

    <s u w y ?>,   '{',
;

my @Dead = 
    <a b c d 𝑒>,        <a b c d e f>,      <a b c>,
    <a , b c d>,        <a b C d e>,        <a b ? ? f>,  Array
;

plan +@Test + @Dead;

subset Char-lc of Str where { so / ^ <[ a..z ? ]> $/ };

sub task(  @a  where { .all ~~ Char-lc } -->Str) {
    if  @a ≠ 5  {                       die "ERR: got trash '@a.raku()'"  }
    my \i =  (@a.first( :k, '?' )  //   die "ERR: got trash '@a.raku()'");
    if  @a.first( :end, :k, '?' ) ≠ i { die "ERR: got trash '@a.raku()'"  }
    
    my @v = @a».ord;

    given i {
        when 0..1 { @v[i]  =  @v[i+1] - ( @v[i+3] - @v[i+2]) }
        when 3..4 { @v[i]  =  @v[i-1] + ( @v[i-2] - @v[i-3]) }
        default   { @v[2]  =  @v[1]   + ( @v[4]   - @v[3]  ) }
    }
    @v[i].chr;
}

for @Test -> @in, $exp {
    is task( @in              ), $exp, "$exp <- @in.join()";
    is task( @in.reverse.Array), $exp, "$exp <- @in.join.flip()";
}
for @Dead -> @in {
    dies-ok { task @in }, 'got trash';
}
done-testing;

my @seq = <s u w y ?>;

say qq{\nInput: @seq = @seq.raku()\nOutput: &task( @seq)};
