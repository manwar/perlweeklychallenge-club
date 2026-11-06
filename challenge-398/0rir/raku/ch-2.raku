#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.e.PREVIEW;
use Test;

=begin comment
May be edited for no good reason:
398-2: String Difference        Submitted by: Mohammad Sajid Anwar
You are given an array of equal length strings.

Write a script to find the difference integer array of each word in the given array. There will be one word with a different array; return that word.

Each words[i] can be converted into a difference integer array difference[i] of length n - 1 where difference[i][j] = words[i][j+1] - words[i][j]

=end comment

my @Test =
    ["ab", "bc", "cd", "zy"],           "zy",
    ["cba", "fed", "azy"],              "azy",
    ["pop", "ada", "beb", "cfc"],       "pop",
    ["aaaa", "zzzz", "mmmm", "aaba"],   "aaba",
    ["Aceg", "Bdfh", "cegi", "azbz"],   "azbz",

    ["ab", "bc", "ZY"],                 "ZY",
    ["no", "ab", "bc", "cd", "ZY"],     "ZY",
    ["no", "ab", "bc", "ZY", "cd"],     "ZY",
    ["no", "ab", "ZY", "bc", "cd"],     "ZY",
    ["no", "ZY", "ab", "bc", "cd"],     "ZY",
    ["ZY", "no", "ab", "bc", "cd"],     "ZY",
;
plan @Test ÷ 2;

sub task( @a where ( @a > 2 and @a.are ~~ Str) -->Str) {

    my @Δ = do for @a -> $word {
        my @w = [ $word.lc.comb».ord ].rotor( 2 => -1)».Array;
        @w.map: { $_ = .[1] - .[0]  };
        @w;
    }

    when @Δ[0] ~~ @Δ[1] { 
        return @a[ @Δ[2..*].first( :k, * !~~ @Δ[0]) + 2 ];
    }
    when @Δ.[0] ~~ @Δ[2] { return @a[1]; }
    default {              return @a[0]; }
}

for @Test -> @in, $exp {
    is task( @in), $exp, "{$exp // $exp.^name()} <- @in.raku()"
}
done-testing;

my @word = flat "aceg" xx 5, "bdfh", "cegi", "azbz";
say "\nInput: @word = (\"", @word.join('", "'), '")'
  ~ "\nOutput: \"", task(@word), '"';
