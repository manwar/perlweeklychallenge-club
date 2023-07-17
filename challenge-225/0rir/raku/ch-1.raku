#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
225-1: Max Words                Submitted by: Mohammad S Anwar
You are given a list of sentences, @list.


A sentence is a list of words that are separated by a single space with no leading or trailing spaces.


Write a script to find out the maximum number of words that appear in a single sentence.

Example 1
Input: @list = ("Perl and Raku belong to the same family.",
                "I love Perl.",
                "The Perl and Raku Conference.")
Output: 8
Example 2
Input: @list = ("The Weekly Challenge.",
                "Python is the most popular guest language.",
                "Team PWC has over 300 members.")
Output: 7
=end comment

=begin interpretation
Solving for the exampled case: From a list of sentences, give the word count of the wordiest sentence.
=end interpretation

my @Test =
    8,    ["Perl and Raku belong to the same family.",
           "I love Perl.",
           "The Perl and Raku Conference."],
    7,    ["The Weekly Challenge.",
           "Python is the most popular guest language.",
           "Team PWC has over 300 members."],
    8,    ["Manwar gets the White Camel in 2023.",
           "The committee, or whoever decided, chose well.",
           "Congratulations to Manwar for the well deserved recognition.",
           "He has my thanks for his service."],
;
plan @Test/2;

my $word-pattern = /\S+/;   # NOTE: Definition of 'word' is loose.

sub word-ct( $a = 'word w.'-->Int) { 
    ( $a ~~ m/:s ^ (<$word-pattern> \s*)+ $/ ).list[0].elems;
}

sub func( @sentence --> Int) { [max=] @ = @sentence».&word-ct; }

my $i= 0;
for @Test -> $exp, @in {
    is func(@in), $exp, "$exp <-- \@Test[" ~ ++$i ~ ']';
    $i++;
}
done-testing;

my $list = @Test[*-1];
print "\nInput: @list = (\"";
print $list.join( "\"\n                \",");
say '")';
say "Output: &func( $list)";

