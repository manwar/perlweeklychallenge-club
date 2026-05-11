#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin note
    The spec is vague: 'abc' and 'abc' doesn't need any operation on the
    string.  I am arbitrarially choosing a True response.  Easy to fix.
=end note


=begin comment
May be edited for space.
370-2: Scramble String          Submitted by: Roger Bell_West
You are given two strings A and B of the same length.
Write a script to return true if string B is a scramble of string A otherwise return false.

String B is a scramble of string A if A can be transformed into B by a single (recursive) scramble operation.

A scramble operation is:

- If the string consists of only one character, return the string.
- Divide the string X into two non-empty parts.
- Optionally, exchange the order of those parts.
- Optionally, scramble each of those parts.
- Concatenate the scrambled parts to return a single string.
￼
Example 1
Input: $str1 = "abc", $str2 = "acb"
Output: true

"abc"
split: ["a", "bc"]
split: ["a", ["b", "c"]]
swap: ["a", ["c", "b"]]
concatenate: "acb"
￼
Example 2
Input: $str1 = "abcd", $str2 = "cdba"
Output: true

"abcd"
split: ["ab", "cd"]
swap: ["cd", "ab"]
split: ["cd", ["a", "b"]]
swap: ["cd", ["b", "a"]]
concatenate: "cdba"
￼
Example 3
Input: $str1 = "hello", $str2 = "hiiii"
Output: false

A fundamental rule of scrambled strings is that they must be anagrams.
￼
Example 4
Input: $str1 = "ateer", $str2 = "eater"
Output: true

"ateer"
split: ["ate", "er"]
split: [["at", "e"], "er"]
swap: [["e", "at"], "er"]
concatenate: "eater"
￼
Example 5
Input: $str1 = "abcd", $str2 = "bdac"
Output: false
￼

=end comment


my @Test =
    # $a        $b          $ret
    "abc",      "acb",      True,
    "abcd",     "cdba",     True,
    "hello",    "hiiii",    False,
    "ateer",    "eater",    True,
    "abcd",     "bdac",     False,
;
plan +@Test ÷ 3;

#say task "eabcd", "cebda";  exit;

multi task( Str:D() $a, Str:D() $b where *.chars ≠ $a.chars) { False }
multi task( Str:D() $a, Str:D() $b where * eq '')            { False }
multi task( Str:D() $a, Str:D() $b where *.chars ≠ $a.chars) { False }
multi task( Str:D() $a, Str:D() $b where * eq $a) { True }
multi task( $a, $b -->Bool) {
    my @in = $a.comb;
    my @goal  = $b.comb;
    return False unless @in.sort ~~ @goal.sort;     # anagrams
    return prep( @in);
    my ($l, $r) = flat bisect @in:
    precheck( $l, @goal);
}

# Halve an array, with an extra elem to tail. Type object if only 1 elem.
sub bisect( @a -->Array) {
    return [ [ @a[ ^(@a div 2)]], [@a[ @a div 2 ..^@a ]] ] if @a > 1;
    Array;
}

enum Side ( None => 0, 'Left', 'Right', 'Both');

# Is left hand an anagram of goal's left or right end?
sub precheck( $l, @goal -->Side) {
    my $left  = @$l.sort ~~ @goal[^@$l].sort;
    my $right = @$l.sort ~~ @goal[@goal - @.l..*].sort;
    return Both if $left && $right;
    return Left if $left;
    return Right if $right;
    None
    return Both if $left and 
}

sub prep( @in -->Bool:D)  {
    return False if precheck @$l;
#    return dig( $l, $r) or dig( $r, $l);
    Bool
}
for @Test -> $in, $goal, $exp {
    is task( $in, $goal), $exp, "{$exp // $exp.^name()} <- $in ∘∘ $goal";
}
done-testing;
=finish
