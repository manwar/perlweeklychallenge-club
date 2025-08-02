#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
308-1: Count Common         Submitted by: Mohammad Sajid Anwar
You are given two array of strings, @str1 and @str2.

Write a script to return the count of common strings in both arrays.

Example 1
Input: @str1 = ("perl", "weekly", "challenge")
       @str2 = ("raku", "weekly", "challenge")
Output: 2
Example 2
Input: @str1 = ("perl", "raku", "python")
       @str2 = ("python", "java")
Output: 1
Example 3
Input: @str1 = ("guest", "contribution")
       @str2 = ("fun", "weekly", "challenge")
Output: 0

=end comment

my @Test =
    {
        str => ['perl', 'weekly', 'challenge'],
        ing => ['raku', 'weekly', 'challenge'],
        exp => 2,
    },{
        str => ['perl', 'raku', 'python'],
        ing => ['python', 'java'],
        exp =>  1,
    },{
        str => ['guest', 'contribution'],
        ing => ['fun', 'weekly', 'challenge'],
        exp => 0,
    },{
        str => ['a', 'b', 'b', 'a'],
        ing => ['a', 'a', 'a'],
        exp => 1,
    },{
        str => ['a', 'b', 'a'],
        ing => ['a', 'a', 'a'],
        exp => 1,
    },{
        str => ['a', 'b', 'a'],
        ing => ['a', 'a', 'a', 'a'],
        exp => 1,
    },{
        str => [],
        ing => [],
        exp => 0,
    },{
        str => [],
        ing => ['a'],
        exp => 0,
    },{
        str => [],
        ing => ['a', 'b', 'c'],
        exp => 0,
    },
;
=begin hmmm
    I take the problem as dealing with uncurated word-lists with neither
    having any kind of higher status, e.g. invalidator, validator.  So I
    find word repetitions in either list to be ignorable.
=end   hmmm

plan +@Test;

only task( @a, @b -->Int) {
    my @x = @a.unique;
    my @y = @b.unique;
    only  task-common( @a, @b -->Int) { + @a.grep( * ~~ @b.any) }
    task-common |(  @x ≥ @y  ?? \(@x, @y)  !! \(@x, @y) );
}

for @Test -> %h {
    my $exp = %h<exp>;
    my @a = %h<str>.flat;
    my @b = %h<ing>.flat;
    is task( @a, @b), $exp,
            "{$exp // $exp.^name()} <- @a.raku() ∘ @b.raku()"
}
done-testing;

my @str1 =("perl", "weekly", "perl", "challenge");
my @str2 =("raku", "weekly", "weekly", "challenge");

say "\nInput: @str1 = @str1[]\n"
    ~ "       @str2 = @str2[]\nOutput: ", task(@str1,@str2);

