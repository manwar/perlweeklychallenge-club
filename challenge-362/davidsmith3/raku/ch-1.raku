#! /usr/bin/env raku

=begin pod
=TITLE
=head2 Task 1
You are given a string containing lowercase letters.

Write a script to transform the string based on the index position of each character (starting from 0). For each character at position i, repeat it i + 1 times.
=CHALLENGE
=head3 Example 1:
Input: "abca"
Output: "abbcccaaaa"

Index 0: "a" -> repeated 1 time  -> "a"
Index 1: "b" -> repeated 2 times -> "bb"
Index 2: "c" -> repeated 3 times -> "ccc"
Index 3: "a" -> repeated 4 times -> "aaaa"

=head3 Example 2:
Input: "xyz"
Output: "xyyzzz"

Index 0: "x" -> "x"
Index 1: "y" -> "yy"
Index 2: "z" -> "zzz"

=head3 Example 3:
Input: "code"
Output: "coodddeeee"

Index 0: "c" -> "c"
Index 1: "o" -> "oo"
Index 2: "d" -> "ddd"
Index 3: "e" -> "eeee"

=head3 Example 4:
Input: "hello"
Output: "heelllllllooooo"

Index 0: "h" -> "h"
Index 1: "e" -> "ee"
Index 2: "l" -> "lll"
Index 3: "l" -> "llll"
Index 4: "o" -> "ooooo"

=head3 Example 5:
Input: "a"
Output: "a"

Index 0: "a" -> "a"

=end pod

sub my-sub(Str:D $s -->Str:D) {
    $s.comb.kv.map(-> $i, $c {$c x ($i+1)}).join
}

multi MAIN(Str:D $text-to-echo) {
    say my-sub($text-to-echo);
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
