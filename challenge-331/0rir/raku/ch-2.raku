#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
INIT $*RAT-OVERFLOW = FatRat;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
331-Task 2: Buddy Strings
Submitted by: Mohammad Sajid Anwar
You are given two strings, source and target.

Write a script to find out if the given strings are Buddy Strings.

If swapping of a letter in one string make them same as the other then they are `Buddy Strings`.

Example 1
Input: $source = "fuck"
       $target = "fcuk"
Output: true

The swapping of 'u' with 'c' makes it buddy strings.

Example 2
Input: $source = "love"
       $target = "love"
Output: false

Example 3
Input: $source = "fodo"
       $target = "food"
Output: true

Example 4
Input: $source = "feed"
       $target = "feed"
Output: true
=end comment

my @Test =
    {   source  => "duck",  target  => "dcuk",  exp => True,
    },{
        source  => "love",  target  => "love",  exp => False,
    },{
        source  => "feed",  target  => "feed",  exp => True,
    },{
        source  => "",      target  => "",      exp => False,
    },{
        source  => "l",     target  => "l",     exp => False,
    },{
        source  => "al",    target  => "al",    exp => False,
    },{
        source  => "al",    target  => "la",    exp => True,
    },{
        source  => "ll",    target  => "ll",    exp => True,
    },{
        source  => "leeko", target  => "eleki", exp => False,
    },{
        source  => "eek", target    => "ek",    exp => False,
    },{
        source  => "eeek", target   => "eeek",  exp => True,
    }
;

plan +@Test ÷ 1;

sub task( Str:D $src, Str:D $trg -->Bool:D) {
    return False if $src.chars < 2  or $trg.chars ≠ $src.chars;
    my @trg = $trg.comb;
    my @a = [Z=>] $src.comb, @trg;
    my $dif = +@a.grep: { .key ne .value };
    given $dif {
        when 2  { True                           }
        when 0  { so @trg.BagHash.values.any > 1 }
        default { False                          }
    }
}
for @Test -> %in  {
    is task( %in<source>, %in<target>),
        %in<exp>, "%in<exp> <- %in<source> ∘∘ %in<target>";
}
done-testing;
