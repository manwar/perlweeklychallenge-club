#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 377 Task 2

Submitted by: Mohammad Sajid Anwar
=head2 Prefix Suffix

You are given an array of strings.

Write a script to find if the two strings (str1, str2) in the given array such that str1 is prefix and suffix of str2. Return the total count of such pairs.

=head3 Example 1:

Input: @array = ("a", "aba", "ababa", "aa")
Output: 4

$array[0], $array[1]: "a" is a prefix and suffix of "aba"
$array[0], $array[2]: "a" is a prefix and suffix of "ababa"
$array[0], $array[3]: "a" is a prefix and suffix of "aa"
$array[1], $array[2]: "aba" is a prefix and suffix of "ababa"

=head3 Example 2:

Input: @array = ("pa", "papa", "ma", "mama")
Output: 2

$array[0], $array[1]: "pa" is a prefix and suffix of "papa"
$array[2], $array[3]: "ma" is a prefix and suffix of "mama"

=head3 Example 3:

Input: @array = ("abao", "ab")
Output: 0

=head3 Example 4:

Input: @array = ("abab", "abab")
Output: 1

$array[0], $array[1]: "abab" is a prefix and suffix of "abab"

=head3 Example 5:

Input: @array = ("ab", "abab", "ababab")
Output: 3

$array[0], $array[1]: "ab" is a prefix and suffix of "abab"
$array[0], $array[2]: "ab" is a prefix and suffix of "ababab"
$array[1], $array[2]: "abab" is a prefix and suffix of "ababab"

=head3 Example 6:

Input: @array = ("abc", "def", "ghij")
Output: 0

=end pod

sub prefix-suffix(@array --> Int) {
    return 0 if @array.elems < 2;
    @array.combinations(2).grep(-> ($left, $right) { ($left.starts-with($right) && $left.ends-with($right)) ||
                                                     ($right.starts-with($left) && $right.ends-with($left)) })
                          .elems;
}

#| Count strings in argument list that are a prefix and a suffix of other strings in the list
multi MAIN(*@str) {
    say prefix-suffix(@str);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => ("a", "aba", "ababa", "aa"), output => 4 ));
    @tests.push(%( input => ("pa", "papa", "ma", "mama"), output => 2 ));
    @tests.push(%( input => ("abao", "ab"), output => 0 ));
    @tests.push(%( input => ("abab", "abab"), output => 1 ));
    @tests.push(%( input => ("ab", "abab", "ababab"), output => 3 ));
    @tests.push(%( input => ("abc", "def", "ghij"), output => 0 ));

    @tests.push(%( input => ("abab", "abab", "abab"), output => 3 ));
    @tests.push(%( input => (), output => 0 ));
    @tests.push(%( input => ("a", ), output => 0 ));
    plan @tests + 3;
    for @tests {
        is prefix-suffix(.<input>), .<output>, "{ .<input> }";
    }
    my $proc = run($*EXECUTABLE, $?FILE, "abc", "def", "ghij", :out, :err);
    is $proc.out.slurp(:close).trim, '0', "cli produces produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
