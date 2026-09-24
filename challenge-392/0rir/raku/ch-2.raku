#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for brevity, clarity or no good reason.
392-2: Words Length Product         Submitted by: Mohammad Sajid Anwar

You are given an array of strings.
Write a script to return the maximum value of len($words[i]) * len($words[j])
where the two words do not share common letters. If no such two words exist,
return 0.
=end comment

my @Test =
    ("a", "ab", "abc", "d", "de", "def"),       9,
    ("a", "aa", "aaa", "aaaa"),                 0,
    ("meet", "app", "code", "sky", "bold"),    16,
    ("a", "ab", "abc", "abcd", "efghi"),       20,
    ("xyz", "w", "abcdefg", "hij"),            21,
    ("xyz",),                                   0,
    (),                                         0,
;
plan +@Test ÷ 2;

sub task( @a -->Int) {
    my $ret = 0;
    my $candi;
    for ^@a.end -> \i {
        for i^..^@a -> \j {
            next if @a[i].contains( any @a[j].comb );
            $candi = @a[i].chars × @a[j].chars;
            $ret = $candi > $ret ?? $candi !! $ret;
        }
    }
    $ret;
}

for @Test -> @in, $exp {
    is task( @in), $exp, "{$exp // $exp.^name()} <- @in.raku()";
}
done-testing;

my @words = "xyz", "w", "abcdefg", "hij";

say qq{\nInput: @words = ("@words.join('", "')")\nOutput: &task( @words)}

