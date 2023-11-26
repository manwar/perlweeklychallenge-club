#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.c;
use Test;

=begin comment

239-2: Consistent Strings       Submitted by: Mohammad S Anwar
Given an array of strings and allowed string having distinct characters.
A string is consistent if all characters in the string appear in the
string allowed.

Write a script to return the number of consistent strings in the given array.

Example 1
Input: @str = ("ad", "bd", "aaab", "baa", "badab")
       $allowed = "ab"
Output: 2

Strings "aaab" and "baa" are consistent since they only contain characters 'a' and 'b'.
Example 2
Input: @str = ("a", "b", "c", "ab", "ac", "bc", "abc")
       $allowed = "abc"
Output: 7
Example 3
Input: @str = ("cc", "acd", "b", "ba", "bac", "bad", "ac", "d")
       $allowed = "cad"
Output: 4

Strings "cc", "acd", "ac", and "d" are consistent.
=end comment

my @Test =
    {   str     => <ad bd aaab baa badab>,
        valid   => "ab",
        exp     => 2,
    },
    {   str     => ("a", "b", "c", "ab", "ac", "bc", "abc"),
        valid   => "abc",
        exp     => 7,
    },
    {   str     => ("cc", "acd", "b", "ba", "bac", "bad", "ac", "d"),
        valid   => "cad",
        exp     => 4,
    },
;

plan +@Test;

sub func( @str, $valid --> Any) {
    my $ok = $valid.comb.Set;
    @str.map( *.comb.Set ⊆ $ok).grep( *.so).elems;
}

for @Test -> %h {
    is func(%h<str>, %h<valid>), %h<exp>, "%h<exp> <= %h<valid>  <- %h<str>";
}

done-testing;
my @str = < alfhja asdflkj alsdjf salkjf lssksaj >;
my $allowed = "alsdkfj";
say "\nInput: @str = @str[]\n     \$allowed = $allowed\nOutput: ",
        &func( @str, $allowed);
exit;

