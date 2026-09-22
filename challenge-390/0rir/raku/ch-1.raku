#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
390-1: Decode String        Submitted by: Mohammad Sajid Anwar

You are given an encoded string.  Write a script to return the string decoded.
The encoding rule is: K[encoded_string], where the encoded_string inside the
square brackets is repeated exactly K > 0 times.

=end comment

# Code does not allow consecutive letters.

my @Test =
    # in            exp
    "2[3[a]]",      "aaaaaa",
    "10[a]",        "aaaaaaaaaa",
    "a2[b]c3[d]e",  "abbcddde",
    "2[a2[b]c]",    "abbcabbc",
    "1[a]2[b3[c]]", "abcccbccc",
    "a",            "a",
    "2[a]",         "aa",
    "2[a]2[b]",     "aabb",
    "z2[a]x",       "zaax",
    "z2[a3[n]]x",   "zannnannnx",
    "A2[a3[n]B2[c]E]Z",   "AannnBccEannnBccEZ",
;
plan 2 × +@Test ÷ 2;

grammar K-code {
    rule  TOP   { <code>                     }
    regex code  { <chunk>+                   }
    regex chunk { <ch>  | <K> '[' <code> ']' }
    token K     { <[1..9]> <:Nd>*            }
    token ch    { <:L>                       }
}

class K-decode {
    method TOP($/)   { make $<code>.made                       }
    method code($/)  { make ($<chunk>».made).join              }
    method chunk($/) { make $<ch> ?? $<ch>.made                ##
                                  !! $<code>.made x $<K>.made; }
    method K($/)     { make $/.Int                             }
    method ch($/)    { make $/.Str                             }
}

sub task( Str:D $a -->Str:D) {
    my $actions = K-decode.new;  
    my $m = K-code.parse: $a, :$actions;
    $m.made;
}

for @Test -> $in, $exp {
    is ?K-code.parse( $in), True, "parsed $in";
     is task( $in), $exp, "$exp <- $in.raku()";
}
done-testing;

my $str = "A2[b3[C]d4[E]f]G";
say qq{\nInput: \$str = "$str"\nOutput: "&task($str)"};
