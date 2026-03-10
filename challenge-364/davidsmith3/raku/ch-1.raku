#! /usr/bin/env raku

=begin pod
=TITLE
=head2 Task 1 Decrypt String
Submitted by: Mohammad Sajid Anwar
You are given a string formed by digits and ‘#'.

Write a script to map the given string to English lowercase characters following the given rules.

- Characters 'a' to 'i' are represented by '1' to '9' respectively.
- Characters 'j' to 'z' are represented by '10#' to '26#' respectively.

=CHALLENGE
=head3 Example 1:
Input: $str = "10#11#12"
Output: "jkab"

10# -> j
11# -> k
1   -> a
2   -> b

=head3 Example 2:
Input: $str = "1326#"
Output: "acz"

1   -> a
3   -> c
26# -> z

=head3 Example 3:
Input: $str = "25#24#123"
Output: "yxabc"

25# -> y
24# -> x
1   -> a
2   -> b
3   -> c

=head3 Example 4:
Input: $str = "20#5"
Output: "te"

20# -> t
5   -> e

=head3 Example 5:
Input: $str = "1910#26#"
Output: "aijz"

1   -> a
9   -> i
10# -> j
26# -> z

=end pod

constant LETTERS = "_abcdefghijklmnopqrstuvwxyz".comb;

sub my-sub(Str:D $s -->Str) {
    $s.subst(/ (\d\d)'#' | (\d) /, { LETTERS[$0] }, :g);
}

multi MAIN(Str:D $cipher-text) {
    say my-sub($cipher-text);
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
    my $string = rx/ \".*\" /;
    for $=pod -> $pod-item {
        for $pod-item.contents -> $pod-block {
            next unless $pod-block ~~ Pod::Heading && $pod-block.level == 3;
            my $text = $pod-block.contents[0].contents.join;
            if $text ~~ / ($string) .* ($string) / {
                @tests.push(%{ input => $0.EVAL, output => $1.EVAL });
            }
        }
    }
    @tests;
}
