#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
315-1: Find Words           Submitted by: Mohammad Sajid Anwar
You are given a list of words and a character.

Write a script to return the index of word in the list where you find the given character.


Example 1
Input: @list = ("the", "weekly", "challenge")
       $char = "e"
Output: (0, 1, 2)

Example 2
Input: @list = ("perl", "raku", "python")
       $char = "p"
Output: (0, 2)

Example 3
Input: @list = ("abc", "def", "bbb", "bcd")
       $char = "b"
Output: (0, 2, 3)
=end comment

my @Test =
    # @in                       $find   @exp
    <the weekly challenge>,     "e",    (0, 1, 2),
    <perl raku python>,         "p",    (0, 2),
    <abc def bbb bcd>,          "b",    (0, 2, 3),
    [],                         "e",    (),
;
my @Dead =
    <abc def bbb bcd">,         "",
    <abc def bbb bcd">,         Str,
    [],                         "",
    [],                         Str,
;
plan @Dead ÷ 2 + @Test ÷ 3;

multi task( List $in, Str:D $f where .chars > 1 ) { die 'Need small needle'    }
multi task( List $in,       ""   -->Array)        { die 'Need a bigger needle' }
multi task( List $in, Str:U $f   -->Array)        { die 'Need a needle'        }
multi task( List $in,   Str:D $f -->Array)        { @ = $in.grep: /$f/,  :k;   }

for @Test -> $in, $find-me, @exp {
    is task( $in, $find-me), @exp, "@exp[] <- $in.raku() ∘∘ $find-me  ";
}
for @Dead -> $in, $find-me {
    dies-ok { task $in, $find-me}, 'died ok';
}
done-testing;

my @list = ("perl", "raku", "python");
my $char = "p";

say qq{\nInput: @list = @list.raku()\n}
  ~ qq{\$char = "$char"\nOutput: }, task(@list,$char);
