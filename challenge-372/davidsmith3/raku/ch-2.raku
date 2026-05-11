#! /usr/bin/env raku

=begin pod
=TITLE
=head2 Challenge 372 Task 2 Largest Substring
Submitted by: Mohammad Sajid Anwar
=CHALLENGE
You are given a string.

Write a script to return the length of the largest substring between two equal characters excluding the two characters. Return -1 if there is no such substring.

=head3 Example 1:
Input: $str = "aaaaa"
Output: 3

For character "a", we have substring "aaa".

=head3 Example 2:
Input: $str = "abcdeba"
Output: 5

For character "a", we have substring "bcdeb".

=head3 Example 3:
Input: $str = "abbc"
Output: 0

For character "b", we have substring "".

=head3 Example 4:
Input: $str = "abcaacbc"
Output: 4

For character "a", we have substring "bca".
For character "b", we have substring "caac".
For character "c", we have substring "aacb".

=head3 Example 5:
Input: $str = "laptop"
Output: 2

For character "p", we have substring "to".

=end pod

sub my-sub(Str:D $str --> Int:D) {
    my @candidate-bookends = $str.comb.Bag.grep(*.value > 1).map(*.key);
    return -1 unless @candidate-bookends;
    @candidate-bookends.map({ ($str.rindex($_) - 1) - $str.index($_) }).max;
}

#| find longest substring
multi MAIN(Str:D $str) {
    say my-sub($str);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests = extract-tests;
    @tests.push(%{ input => "", output => -1 });
    @tests.push(%{ input => "abc", output => -1 });
    @tests.push(%{ input => " b ", output => 1 });
    plan +@tests;
    for @tests {
        is my-sub(.<input>), .<output>, "{.<input>}";
    }
}

sub extract-tests(--> Array[Hash]) {
    my Hash @tests;
    my $string = / '"' <-["]>* '"' /;
    my $int = / << \d+ >> /;
    for $=pod -> $pod-item {
        for $pod-item.contents -> $pod-block {
            next unless $pod-block ~~ Pod::Heading && $pod-block.level == 3;
            my $text = $pod-block.contents[0].contents.join;
            if $text ~~ / ($string) .* ($int)  / {
                @tests.push(%{ input => $0.EVAL, output => +$1 });
            }
        }
    }
    @tests;
}
