#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
Task 1: Count Vowel
Submitted by: Mohammad Sajid Anwar
You are given a string.

Write a script to return all possible vowel substrings in the given string. A vowel substring is a substring that only consists of vowels and has all five vowels present in it.
=end comment

my @Test =
    # in                exp
    "aeiou",         ("aeiou",),
    "aaeeeiioouu",   ("aaeeeiioou", "aaeeeiioouu", "aeeeiioou", "aeeeiioouu"),
    "aeiouuaxaeiou", ("aeiou", "aeiou", "eiouua", "aeiouu", "aeiouua"),
    "uaeiou",        ("aeiou", "uaeio", "uaeiou"),
    "aeioaeioa",     (),
;
plan +@Test ÷ 2;

constant \MIN-STR = 5;

sub task ( $a -->List ) {
    my @ret;
    my $m = $a ~~ m:ex/ <[aeiouAEIOU]>**5..* /;
    for $m[*]».Str {
       my $s = .lc;
       next unless $s.contains('a') and $s.contains('e')
               and $s.contains('i') and $s.contains('o')
               and $s.contains('u');
        @ret.push: $_;
    }
    @ret.List;
}

for @Test -> $in, @exp {
    is task( $in).sort, @exp.sort, "{@exp // @exp.^name()} <- $in.raku()";
}
done-testing;

my $str = "aaeeeiioouu";
say qq{\nInput: \$str = "$str"\nOutput: ("{&task($str).join('","')}")};
