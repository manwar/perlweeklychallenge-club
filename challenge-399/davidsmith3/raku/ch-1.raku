#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 399 Task 1

Submitted by: Mohammad Sajid Anwar
=head2 Longest Repeating Character

You are given a string str and an integer k > 0.

Write a script to choose any character of str and change it to another character. You may perform this operation up to k times. Return the length of the longest reachable substring of a single letter.

=head3 Example 1:

Input: $str = "AAAAA", $k = 2
Output: 5

Every character in the string is already the same letter "A".
The maximum operations allowed (k = 2) do not even need to be used.
The entire string of length 5 is already the longest valid substring.

=head3 Example 2:

Input: $str = "ABCDE", $k = 4
Output: 5

All 5 characters in the string are distinct.
The most frequent character occurs only 1 time.
To turn the entire string into a single repeated character, we need to replace 5 - 1 = 4 characters.
Since k = 4, we can replace "B","C","D", and "E" with "A" to form "AAAAA".

=head3 Example 3:

Input: $str = "AAABBBBAA", $k = 1
Output: 5

If we target "A", we could change the "B" in "AAAB" (k=1 replacement) to get length 4 ("AAAA").
If we target "B", we can pick the substring "BBBBA" and change the single trailing "A" to "B" (k=1 replacement) to form "BBBBB", which gives a length of 5.
Targeting "B" gives better result than targeting "A".

=head3 Example 4:

Input: $str = "ABACADA", $k = 2
Output: 5

Look at the substring [0..4] which is "ABACA" (length 5).
In this window, "A" appears 3 times, and there are 2 non-"A" characters ("B" and "C").
With k = 2, we can replace "B" and "C" with "A" to form "AAAAA".

Look at the substring [2..6] which is "ACADA" (length 5).
Here, "A" appears 3 times, and non-"A" characters ("C" and "D") count to 2.
Replacing them gives "AAAAA".

In both cases, the maximum valid length is 5.

=head3 Example 5:

Input: $str = "BAAABAAAA", $k = 1
Output: 8

The string has two groups of "A"s separated by a single "B" ("AAABAAAA").

We can replace the character 4 "B" with an "A" to get a sequence of 8 "A".

=end pod

sub find-run(@arr --> Int) {
    return 0 unless @arr.elems > 0;
    my $longest = 1;
    my $i = 0;
    while $i < (@arr.elems - 1) {
        my $current = 1;
        while (($i + $current) < @arr.elems) && (@arr[$i] eq @arr[$i + $current]) {
            $current++;
        }
        $longest = max($longest, $current);
        $i += $current;
    }
    $longest;
}

multi longest-repeating-character(Str:D $str, Int:D $k where * >= 0 --> Int) {
    my @uniques = $str.comb.unique;
    return $str.chars unless @uniques.elems > 1;
    my @str-chars = $str.comb.List;
    my $longest = 1;
    for @uniques -> $target {
        my @target-indexes = @str-chars.pairs
                                       .grep({ .value !eq $target })
                                       .map({ .key });
        return @str-chars.elems if $k >= @target-indexes.elems;
        for @target-indexes.combinations($k).map({ .Set }) -> $combination {
            my @candidate;
            for ^@str-chars.elems -> $i {
                @candidate.push($i (elem) $combination ?? $target !! @str-chars[$i]);
            }
            $longest = max($longest, find-run(@candidate));
        }
    }
    $longest;
}

multi longest-repeating-character(Str:D $str, Int:D $k) {
    die "Unexpected negative input $k";
}

#| Return length of longest repeating characters in STR after maximum K substitutions
multi MAIN(Str:D $str, Int:D $k) {
    say longest-repeating-character($str, $k);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => ("AAAAA", 2), output => 5));
    @tests.push(%( input => ("ABCDE", 4), output => 5));
    @tests.push(%( input => ("AAABBBBAA", 1), output => 5));
    @tests.push(%( input => ("ABACADA", 2), output => 5));
    @tests.push(%( input => ("BAAABAAAA", 1), output => 8));
    @tests.push(%( input => ("", 82), output => 0));
    @tests.push(%( input => ("", 0), output => 0));
    @tests.push(%( input => ("A", 1), output => 1));
    @tests.push(%( input => ("AAAB", 82), output => 4));
    @tests.push(%( input => ("ABCC", 1), output => 3));
    @tests.push(%( input => ("AABCCC", 1), output => 4));
    @tests.push(%( input => ("ABC", 0), output => 1));
    @tests.push(%( input => ("AaBb", 1), output => 2));

    my @should-throw;
    @should-throw.push(%( input => ("", -1) ));

    plan @tests + @should-throw + 3;
    for @tests {
        is longest-repeating-character(|.<input>), .<output>, "{ .<input>.raku }";
    }
    for @should-throw {
        throws-like { longest-repeating-character(|.<input>) },
                    Exception,
                    "dies on { .<input>.raku }",
                    message => /Unexpected/;
    }
    my $proc = run($*EXECUTABLE, $?FILE, 'AAA', '1', :out, :err);
    is $proc.out.slurp(:close).trim, '3', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
