#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.e.PREVIEW;
use Test;

=begin comment
Edited for space.
340-1: Duplicate Removals
Submitted by: Mohammad Sajid Anwar
You are given a string, $str, consisting of lowercase English letters.

Write a script to return the final string after all duplicate removals have been made. Repeat duplicate removals on the given string until we no longer can.

A duplicate removal consists of choosing two adjacent and equal letters and removing them.

=end comment

my @Test =
    # Str,            Str,      #deader
    '',             '',
    'bb',           '',
    'abc',          'abc',
    'abbaca',       'ca',
    'azxxzy',       'ay',
    'aaaaaaaa',     '',
    'aabccba',      'a',
    'abcddcba',     '',
;
plan +@Test ÷ 2;

sub task( Str:D $a is copy -->Str) {
   while $a ~~ s:g/ (<:Ll>) $0+ //  { ; }
   $a;
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp.raku() // $exp.^name()} <- $in.raku()";
}
done-testing;

my $str = 'aabccba';
say "\nInput: $str = \"", $str, "\"\nOutput: &task($str).raku()";
