#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
317-1: Acronyms        Submitted by: Mohammad Sajid Anwar
You are given an array of words and a word.
Write a script to return true if concatenating the first letter of each word in the given array matches the given word, return false otherwise.

Example 1
Input: @array = ("Perl", "Weekly", "Challenge")
       $word  = "PWC"
Output: true

Example 2
Input: @array = ("Bob", "Charlie", "Joe")
       $word  = "BCJ"
Output: true

Example 3
Input: @array = ("Morning", "Good")
       $word  = "MM"
Output: false
=end comment

my @Test =
    # word list                             word    expect
    ["Perl", "Weekly", "Challenge"],    "PWC",  True,
    ["Bob", "Charlie", "Joe"],          "BCJ",  True,
    ["bob", "charlie", "Joey"],         "BCJ",  True,
    ["Morning", "Good"],                "MM",   False,
;
my @Dead =
    ("",),                              Str,
    (),                                 "",
    ("",),                              "",
    ("Abc"),                            "",
    ("Abc", "",    "Bcd"),              "AB",
    ("bob", "", "Joey"),                "BCJ",
    ("",),                              "A",
    Array,                              "A",
;
plan (@Test ÷ 3 + @Dead ÷ 2);

multi task( Str:U, @list )                    { die 'Word arg undefined.'}
multi task( Str:D $word where * eq '', @list) { die 'Word arg empty.'}
multi task( Str:D $word, Array:U )            { die 'List arg undefined.'}
multi task( Str:D $word, Empty )              { die 'List arg Empty.'}
multi task( Str:D $word, @list where *.first('').defined )
                                              { die 'List contains "".'}
multi task( Str:D $word, @list -->Bool) {
    return False if @list.elems ≠ $word.chars;
    so $word.fc eq all @list».substr(0,1).join.fc;
}

for @Test -> @wordlist, $word, $exp {
    is task( $word, @wordlist), $exp, "$exp <- @wordlist.raku() ∘∘ $word";
}
for @Dead -> $wordlist, $word {
    dies-ok { task $word, $wordlist},
        "Undef, Empty, or missmatch: @$wordlist.raku() ∘∘ $word.raku()";
}
done-testing;

my @array = < Perl Weekly Challenge challenging weekly for 317 weeks>;
my $word  = "PWCCWF3W";
say qq{\nInput: @array = ("}  ~ @array.join('", "') ~ ")\n"
    ~ "\$word  = $word\n"
    ~ "Output: { task $word, @array}";

