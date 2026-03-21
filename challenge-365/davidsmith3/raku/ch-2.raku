#! /usr/bin/env raku

=begin pod
=TITLE
=head2 Task 2 Valid Token Counter
Submitted by: Mohammad Sajid Anwar
=CHALLENGE
You are given a sentence.

Write a script to split the given sentence into space-separated tokens and count how many are valid words. A token is valid if it contains no digits, has at most one hyphen surrounded by lowercase letters, and at most one punctuation mark (!, ., ,) appearing only at the end.

=head3 Example 1:
Input: $str = "cat and dog"
Output: 3

Tokens: "cat", "and", "dog"

=head3 Example 2:
Input: $str = "a-b c! d,e"
Output: 2

Tokens: "a-b", "c!", "d,e"
"a-b" -> valid (one hyphen between letters)
"c!"  -> valid (punctuation at end)
"d,e" -> invalid (punctuation not at end)

=head3 Example 3:
Input: $str = "hello-world! this is fun"
Output: 4

Tokens: "hello-world!", "this", "is", "fun"
All satisfy the rules.

=head3 Example 4:
Input: $str = "ab- cd-ef gh- ij!"
Output: 2

Tokens: "ab-", "cd-ef", "gh-", "ij!"
"ab-"   -> invalid (hyphen not surrounded by letters)
"cd-ef" -> valid
"gh-"   -> invalid
"ij!"   -> valid

=head3 Example 5:
Input: $str = "wow! a-b-c nice."
Output: 2

Tokens: "wow!", "a-b-c", "nice."
"wow!"  -> valid
"a-b-c" -> invalid (more than one hyphen)
"nice." -> valid

=end pod

sub my-sub(Str:D $str -->Int) {
    $str
        .words
        .grep(
            / ^ <[a..zA..Z]>* [<[a..z]> '-' <[a..z]>]? <[a..zA..Z]>* <[!.,]>? $ /)
        .elems;
}

multi MAIN(Str:D $str) {
    say my-sub($str);
}

multi MAIN(Bool:D :$test) {
    use Test;

    my @tests = extract-tests;
    plan +@tests;
    for @tests {
        is my-sub( .<input> ), .<output>, "{.<input>}";
    }
}

sub extract-tests(-->Array[Hash]) {
    my Hash @tests;
    my $string = rx/ '"' .* '"' /;
    my $int = / \d+ /;
    for $=pod -> $pod-item {
        for $pod-item.contents -> $pod-block {
            next unless $pod-block ~~ Pod::Heading && $pod-block.level == 3;
            my $text = $pod-block.contents[0].contents.join;
            if $text ~~ / ($string) .* ($int) / {
                @tests.push(%{ input => $0.EVAL, output => +$1 });
            }
        }
    }
    @tests;
}
