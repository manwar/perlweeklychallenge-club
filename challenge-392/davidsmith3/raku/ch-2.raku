#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 392 Task 2

Submitted by: Mohammad Sajid Anwar
=head2 Words Length Product

You are given an array of strings.

Write a script to return the maximum value of len($words[i]) * len($words[j]) where the two words do not share common letters. If no such two words exist, return 0.

=head3 Example 1:

Input: @words = ("a", "ab", "abc", "d", "de", "def")
Output: 9

Two words are "abc" and "def".

=head3 Example 2:

Input: @words = ("a", "aa", "aaa", "aaaa")
Output: 0

Since no two words can be chosen without sharing letters, the result is 0.

=head3 Example 3:

Input: @words = ("meet", "app", "code", "sky", "bold")
Output: 16

Two words are "meet" and "bold".

=head3 Example 4:

Input: @words = ("a", "ab", "abc", "abcd", "efghi")
Output: 20

Two words are "abcd" and "efghi".

=head3 Example 5:

Input: @words = ("xyz", "w", "abcdefg", "hij")
Output: 21

Two words are "abcdefg" and "hij".

=end pod

sub product(Str:D $left, Str:D $right --> Int) {
    return 0 if $left.comb.Set (&) $right.comb.Set;
    $left.chars * $right.chars;
}

sub words-length-product(@words, --> Int) {
    return 0 if @words.elems < 2;
    return @words.combinations(2).map({ product(.head, .tail) }).max;
}

#| compute the words length product of WORDS
multi MAIN(*@words) {
    say words-length-product(@words);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => ("a", "ab", "abc", "d", "de", "def"), output => 9));
    @tests.push(%( input => ("a", "aa", "aaa", "aaaa"), output => 0));
    @tests.push(%( input => ("meet", "app", "code", "sky", "bold"), output => 16));
    @tests.push(%( input => ("a", "ab", "abc", "abcd", "efghi"), output => 20));
    @tests.push(%( input => ("xyz", "w", "abcdefg", "hij"), output => 21));
    @tests.push(%( input => [], output => 0));
    @tests.push(%( input => ["a"], output => 0));

    plan @tests + 3;
    for @tests {
        is words-length-product(.<input>), .<output>, "{ .<input>.raku }";
    }
    my $proc = run($*EXECUTABLE, $?FILE, 'foo', 'bar', :out, :err);
    is $proc.out.slurp(:close).trim, '9', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
