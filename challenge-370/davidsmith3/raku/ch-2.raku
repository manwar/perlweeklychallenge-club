#! /usr/bin/env raku

=begin pod
=TITLE
=head2 Challenge 370 Task 2
Submitted by: Roger Bell_West
=CHALLENGE
You are given two strings A and B of the same length.

Write a script to return true if string B is a scramble of string A otherwise return false.

String B is a scramble of string A if A can be transformed into B by a single (recursive) scramble operation.

A scramble operation is:

- If the string consists of only one character, return the string.
- Divide the string X into two non-empty parts.
- Optionally, exchange the order of those parts.
- Optionally, scramble each of those parts.
- Concatenate the scrambled parts to return a single string.

=head3 Example 1:
Input: $str1 = "abc", $str2 = "acb"
Output: true

"abc"
split: ["a", "bc"]
split: ["a", ["b", "c"]]
swap: ["a", ["c", "b"]]
concatenate: "acb"

=head3 Example 2:
Input: $str1 = "abcd", $str2 = "cdba"
Output: true

"abcd"
split: ["ab", "cd"]
swap: ["cd", "ab"]
split: ["cd", ["a", "b"]]
swap: ["cd", ["b", "a"]]
concatenate: "cdba"

=head3 Example 3:
Input: $str1 = "hello", $str2 = "hiiii"
Output: false

A fundamental rule of scrambled strings is that they must be anagrams.

=head3 Example 4:
Input: $str1 = "ateer", $str2 = "eater"
Output: true

"ateer"
split: ["ate", "er"]
split: [["at", "e"], "er"]
swap: [["e", "at"], "er"]
concatenate: "eater"

=head3 Example 5:
Input: $str1 = "abcd", $str2 = "bdac"
Output: false

=end pod

sub anagrams(Str:D $a, Str:D $b --> Bool) {
    $a.comb.sort.join eq $b.comb.sort.join;
}

sub is-scramble(Str:D $a, Str:D $b --> Bool) {
    return False unless anagrams($a, $b);
    return True if $a.chars == 1;
    for 1..^$a.chars -> $point {
        # is xyz is a scramble of abc?
        # at each pivot point
        # abc splits into        a | bc
        # and must scramble into x | yz
        # or swap occurs and     bc | a
        # must scramble into     xy | z
        return True if (is-scramble($a.substr(0, $point), $b.substr(0, $point)) &&
                        is-scramble($a.substr($point), $b.substr($point))) ||
                       (is-scramble($a.substr($point), $b.substr(0, $a.chars - $point)) &&
                        is-scramble($a.substr(0, $point), $b.substr($a.chars - $point)));
    }
    False;
}

sub my-sub(Str:D $a, Str:D $b --> Bool) {
    is-scramble($a, $b);
}

#| determine if string b is a scramble of string a
multi MAIN(Str:D $a, Str:D $b) {
    say my-sub($a, $b);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests = extract-tests;
    @tests.push(%{ input => ("ateerateerateerateer", "eatereatereatereater"), output => True });
    my @anagram-tests;
    @anagram-tests.push(%{ input => ("a", "a"), output => True });
    @anagram-tests.push(%{ input => ("ab", "ba"), output => True });
    @anagram-tests.push(%{ input => ("ab", "b"), output => False });
    @anagram-tests.push(%{ input => ("ab", "bb"), output => False });

    plan @tests + @anagram-tests;
    for @tests {
        is my-sub(|.<input>), .<output>, "{.<input>}";
    }
    for @anagram-tests {
        is anagrams(|.<input>), .<output>, "anagrams: {.<input>}";
    }
}

sub extract-tests(--> Array[Hash]) {
    my Hash @tests;
    my $string = / '"' <-["]>* '"' /;
    my $int = / << \d+ >> /;
    my $bool = / << [ [t|T] rue | [f|F] alse ] >> /;
    for $=pod -> $pod-item {
        for $pod-item.contents -> $pod-block {
            next unless $pod-block ~~ Pod::Heading && $pod-block.level == 3;
            my $text = $pod-block.contents[0].contents.join;
            if $text ~~ / ($string) .* ($string) .* ($bool)  / {
                @tests.push(%{ input => ($0.EVAL, $1.EVAL), output => $2.tc.EVAL });
            }
        }
    }
    @tests;
}
