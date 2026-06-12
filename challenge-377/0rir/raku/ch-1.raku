#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
377-1: Reverse Existence            Submitted by: Mohammad Sajid Anwar
You are given a string.  Write a script to find whether any substring
of length 2 is also present in the reverse of the given string.
=end comment

my @Test =
    "abcba",        True,
    "racecar",      True,
    "abcd",         False,
    "banana",       True,
    "hello",        True,
;
plan +@Test;

sub task-comb( Str:D() $a where *.chars > 1 -->Bool:D) {
    my @r = ($a.comb( /../ )».flip).unique;
    so $a.contains: @r.any;
}


sub task-succ( Str:D() $a where $a.chars > 1 -->Bool:D) {
    when $a.chars ≤  1 {  False }
    when $a.chars == 2  { False if $a.substr(0,1) eq $a.substr(1,1) }
    my $w = 0..2;
    while $w.max < $a.chars {
        my $ori = $w.min;
        my $l = $a.substr(   $ori, 1);
        my $c = $a.substr( ++$ori, 1);
        my $r = $a.substr( ++$ori, 1);
        return True if $l eq $c  or   $c eq $r  or $l eq $r;
        $w +=1;
    }
    False;
}

for @Test -> $in, $exp {
    is task-succ( $in), $exp, "succ {$exp // $exp.^name()} <- $in.raku()";
    is task-comb( $in), $exp, "comb {$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

=finish

Reverse of given string is "abcba".
The substring "ab" in original string is also present in the reverse string too.
￼
Example 2
Input: $str = "racecar"
Output: true

The substring "ce" is present in both.
￼
Example 3
Input: $str = "abcd"
Output: false
￼
Example 4
Input: $str = "banana"
Output: true

The substring "an" is present in both.
￼
Example 5
Input: $str = "hello"
Output: true

The substring "ll" is present in both.
￼

