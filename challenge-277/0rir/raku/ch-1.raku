#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
277-1: Count Common         Submitted by: Mohammad Sajid Anwar
You are given two array of strings, @words1 and @words2.  Return the count
of words that appears in both arrays exactly once.

Example 1
Input: @words1 = ("Perl", "is", "my", "friend")
       @words2 = ("Perl", "and", "Raku", "are", "friend")
Output: 2

The words "Perl" and "friend" appear once in each array.
Example 2
Input: @words1 = ("Perl", "and", "Python", "are", "very", "similar")
       @words2 = ("Python", "is", "top", "in", "guest", "languages")
Output: 1
Example 3
Input: @words1 = ("Perl", "is", "imperative", "Lisp", "is", "functional")
       @words2 = ("Crystal", "is", "similar", "to", "Ruby")
Output: 0

=end comment

my @Test =
  # exe      list / list
     0, (), (),
     0, (), < Pi is positive and is long >,
     1, ('red',), ('Red', 'dog'),
     2, ("Perl", "is", "my", "friend"),
        ("Perl", "and", "Raku", "are", "friend"),
     1, ("Perl", "and", "Python", "are", "very", "similar"),
        ("Python", "is", "top", "in", "guest", "languages"),
     0, ("Perl", "is", "imperative", "Lisp", "is", "functional"),
        ("Crystal", "is", "similar", "to", "Ruby"),
;
plan @Test ÷ 3;

sub task( @a, @b --> Int) {
    (   (@a».fc).BagHash.grep( *.value == 1 )
            ∩
        (@b».fc).BagHash.grep( *.value == 1 )
    ).elems;
}

for @Test -> $exp, @a, @b, {
    is task(@a, @b), $exp, "$exp <- @a[] +/+ @b[]";
}

done-testing;

my @word1 = < I am positive>;
my @word2 = < Pi is positive>;

say   "\nInput: @words1 = @word1.List.raku()"
  ~   "\n       @words2 = @word2.List.raku()"
  ~   "\n Output: ", task(@word1, @word2);
