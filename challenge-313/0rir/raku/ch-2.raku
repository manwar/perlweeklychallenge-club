#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
313-2: Reverse Letters          Submitted by: Mohammad Sajid Anwar
You are given a string.
Write a script to reverse only the alphabetic characters in the string.

Example 1
Input: $str = "p-er?l"
Output: "l-re?p"
Example 2
Input: $str = "wee-k!L-y"
Output: "yLk-e!e-w"
Example 3
Input: $str = "_c-!h_all-en!g_e"
Output: "_e-!g_nel-la!h_c"
=end comment

my @Test =
    #   L                   R
    "p-er?l",               "l-re?p",
    "wee-k!L-y",            "yLk-e!e-w",
    "_c-!h_all-en!g_e",     "_e-!g_nel-la!h_c",
    "",                     "",
    "a",                    "a",
    "b",                    "b",
    "a!",                   "a!",
    "!a",                   "!a",
    "!@",                   "!@",
    "b!d",                  "d!b",
    "@bd!",                 "@db!",
    "@bcd!",                "@dcb!",
    "@b!d#",                "@d!b#",
    "abcde",                "edcba",
;
plan +@Test;

sub task( Str:D $in -->Str:D) {
    my @a = $in.comb;
    my ($a, $z) = 0, @a.end;        # Set initial slice range.
    loop {
                            # Find indices to swapables
        my $frst = @a[$a..$z].first( * ~~ /<:L>/, :k)       // +@a;
        my $lst  = @a[$a..$z].first( * ~~ /<:L>/, :k, :end) // -1;
      last if $a + $frst ≥ $a + $lst;     # Lone or none found.
                            # Swap.
        (@a[$a+$frst], @a[$a+$lst]) = @a[$a+$lst], @a[$a+$frst];
                            # Shrink search area.
        $z  = $a + $lst -1;
        $a += $frst + 1;
    }
    return @a.join;
}

for @Test -> $l, $r {
    is task( $l), $r, "{$r // $r.^name()} <- $l.raku()";
    is task( $r), $l, "{$l // $l.^name()} <- $r.raku()";
}
done-testing;

my $str = "ye@h_wt∘0hw";
say qq{\nInput: \$str = "$str"\nOutput: &task($str)};

