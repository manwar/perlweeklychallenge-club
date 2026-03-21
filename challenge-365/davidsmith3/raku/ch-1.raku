#! /usr/bin/env raku

=begin pod
=TITLE
=head2 Task 1 Alphabet Index Digit Sum
Submitted by: Mohammad Sajid Anwar
=CHALLENGE
You are given a string $str consisting of lowercase English letters, and an integer $k.

Write a script to convert a lowercase string into numbers using alphabet positions (a=1 … z=26), concatenate them to form an integer, then compute the sum of its digits repeatedly $k times, returning the final value.

=head3 Example 1:
Input: $str = "abc", $k = 1
Output: 6

Conversion: a = 1, b = 2, c = 3 -> 123
Digit sum: 1 + 2 + 3 = 6

=head3 Example 2:
Input: $str = "az", $k = 2
Output: 9

Conversion: a = 1, z = 26 -> 126
1st sum: 1 + 2 + 6 = 9
2nd sum: 9

=head3 Example 3:
Input: $str = "cat", $k = 1
Output: 6

Conversion: c = 3, a = 1, t = 20 -> 3120
Digit sum: 3 + 1 + 2 + 0 = 6

=head3 Example 4:
Input: $str = "dog", $k = 2
Output: 8

Conversion: d = 4, o = 15, g = 7 -> 4157
1st sum: 4 + 1 + 5 + 7 = 17
2nd sum: 1 + 7 = 8

=head3 Example 5:
Input: $str = "perl", $k = 3
Output: 6

Conversion: p = 16, e = 5, r = 18, l = 12 -> 1651812
1st sum: 1 + 6 + 5 + 1 + 8 + 1 + 2 = 24
2nd sum: 2+4 = 6
3rd sum: 6
=end pod

constant LETTERS = "_abcdefghijklmnopqrstuvwxyz";

multi my-sub(Str:D $str where * ~~ / <[a..z]>+ /, Int:D $k where * > 0 -->Int) {
    my $current = $str.comb.map({ LETTERS.index($_) }).join;
    $current = [+] $current.comb for ^$k;
    $current;
}

multi my-sub(Str:D $str, Int:D $k -->Int) {
    die "Unexpected input.  Got $str and $k.";
}

multi MAIN(Str:D $str, Int:D $k) {
    say my-sub($str, $k);
}

multi MAIN(Bool:D :$test) {
    use Test;

    my @tests = extract-tests;
    plan +@tests;
    for @tests {
        is my-sub( |.<input> ), .<output>, "{.<input>}";
    }
}

sub extract-tests(-->Array[Hash]) {
    my Hash @tests;
    my $string = / '"' .* '"' /;
    my $int = / \d+ /;
    for $=pod -> $pod-item {
        for $pod-item.contents -> $pod-block {
            next unless $pod-block ~~ Pod::Heading && $pod-block.level == 3;
            my $text = $pod-block.contents[0].contents.join;
            if $text ~~ / ($string) .* ($int) .* ($int) / {
                @tests.push(%{ input => ($0.EVAL, +$1), output => +$2 });
            }
        }
    }
    @tests;
}
