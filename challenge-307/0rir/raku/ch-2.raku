#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
307-Task 2: Find Anagrams       Submitted by: Mohammad Sajid Anwar
You are given a list of words, @words.

Write a script to find any two consecutive words and if they are anagrams, drop the first word and keep the second. You continue this until there is no more anagrams in the given list and return the count of final list.

Example 1
Input: @words = ("acca", "dog", "god", "perl", "repl")
Output: 3

Step 1: "dog" and "god" are anagrams, so dropping "dog" and keeping "god" => ("acca", "god", "perl", "repl")
Step 2: "perl" and "repl" are anagrams, so dropping "perl" and keeping "repl" => ("acca", "god", "repl")
Example 2
Input: @words = ("abba", "baba", "aabb", "ab", "ab")
Output: 2

Step 1: "abba" and "baba" are anagrams, so dropping "abba" and keeping "baba" => ("baba", "aabb", "ab", "ab")
Step 2: "baba" and "aabb" are anagrams, so dropping "baba" and keeping "aabb" => ("aabb", "ab", "ab")
Step 3: "ab" and "ab" are anagrams, so dropping "ab" and keeping "ab" => ("aabb", "ab")

=end comment

my @Test =
    (),                                           0,
    ('ab',),                                      1,
    ('ba', 'ab'),                                 1,
    ('ac', 'ba'),                                 2,
    ("abba", "baba", "aabb", "ab", "ab"),         2,
    ("acca", "dog", "god", "perl", "repl"),       3,
    ('fussy', 'fuzzy', 'fussy', 'furry',),        4,
    ('fuzzy', 'fussy', 'fussy', 'furry',),        3,
    ('ab', 'ba', 'ab', 'ba', 'da'),               2,
    ('ab', 'da', 'ba', 'ab', 'ba'),               3,
    ('ab', 'ba', 'ab', 'da', 'ba'),               3,
;
plan @Test ÷ 2;

only task( @a is copy -->Int) {
    my $deleted = 0;
    @a.=map({.split('').sort.join });
    for 1..^@a -> $i {
        ++$deleted if @a[$i-1] eq @a[$i];
    }
    @a.elems - $deleted;
}

for @Test -> @a, $exp {
    is task( @a), $exp, "{$exp // $exp.^name()} <- @a.raku()"
}
done-testing;

my @word = "acca", "dog", "god", "perl", "repl";
say "\nInput: @word = ( ", @word.map('"' ~ * ~ '"' ).join(' ,'), ")";
say "Output: ", @word.&task;

