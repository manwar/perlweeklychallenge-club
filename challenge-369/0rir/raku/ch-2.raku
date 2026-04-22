#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
369-2: Group Division      Submitted by: Mohammad Sajid Anwar
You are given a string, group size and filler character.

Write a script to divide the string into groups of given size. In the last group if the string doesn’t have enough characters remaining fill with the given filler character.
=end comment

my @Test =
    # str           size    fill    exp
    "RakuPerl",     4,      "*",    ("Raku", "Perl"),
    "Python",       5,      "0",    ("Pytho", "n0000"),
    "12345",        3,      "x",    ("123", "45x"),
    "HelloWorld",   3,      "_",    ("Hel", "loW", "orl", "d__"),
    "AI",           5,      "!",    "AI!!!",
    "",             3,      '~',    "~~~",
;
plan +@Test ÷ 4;

multi task( '',
            Int:D \size where * > 0,
            Str:D \filler where *.chars == 1 -->Array) {
    [ filler x size ];
}
multi task( Str:D $str is copy,
            Int:D \size where * > 0,
            Str:D \filler where *.chars == 1 -->Array) {
    my $pad-size =  size - $str.chars % size;
    $pad-size = 0 if size == $pad-size;
    my $pad =       filler x $pad-size;
    ($str ~ $pad).comb( size).Array;
}

for @Test -> $in, $size, $filler, $exp {
    is task( $in, $size, $filler), $exp, "'$exp' <- $in ∘∘ $size ∘∘ $filler";
}

done-testing;

my $str = "HelloWorld";
my $size = 3;
my $filler = "∘";

sub show-task( $str, $size, $filler ) {
    my @ary = task( $str, $size, $filler );
    return "(\"@ary.join('", "')\")" if @ary.elems > 1;
    qq{"@ary[0]"}
}
say qq{\nInput: \$str = "$str", \$size = $size, \$filler = "$filler"},
  ~ qq{\nOutput: }, show-task( $str, $size, $filler);
