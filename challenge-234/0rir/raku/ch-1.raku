#!/usr/bin/env rak;
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ;
use v6.d;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
234-1: Common Characters
Submitted by: Mohammad S Anwar
You are given an array of words made up of alphabetic characters only.

Write a script to return all alphabetic characters that show up in all words including duplicates.

Example 1
Input: @words = ("java", "javascript", "julia")
Output: ("j", "a")
Example 2
Input: @words = ("bella", "label", "roller")
Output: ("e", "l", "l")
Example 3
Input: @words = ("cool", "lock", "cook")
Output: ("c", "o")

=end comment

my @Test =
    ("j" => 1, "a" =>1).sort,    ("java", "javascript", "julia"),
    ("e" => 1, "l" =>2),         ("bella", "label", "roller"),
    ("c" => 1, "o" =>1),         ("cool", "lock", "cook"),
;

plan @Test ÷ 2;

func();

# returns array of pair
sub func( @i = @Test[1] --> Seq) {
    my @char = @i.join.comb.sort.unique;
    my $hash;

    for ^@i -> $i {
        for @i[$i].comb -> $c { ++ $hash{$c}[$i]; }
    }

    my @return;
    for $hash.kv -> $k, @v {
        for @v { $_ //= 0; }
        next if @v.elems < @i.elems;
        @return.push: $k => @v.min if @v.min > 0;
    }
    @return.sort;
}

sub _str( @in --> Str ) {
    my @return;
    for @in -> $p {
        @return.push( $p.key ) for ^$p.value;
    }
    @return.sort.join( ", ");
}

for @Test -> @exp, @in {
    is func(@in), @exp, "@exp.raku() <- @in.raku()";
}

done-testing;

my @word =  "bella", "label", "roller";
say "\nInput: @word = @word.raku()\nOutput: &_str(func( @word))";
exit;

