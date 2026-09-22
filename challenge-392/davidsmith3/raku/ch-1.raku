#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 392 Task 1

Submitted by: Mohammad Sajid Anwar
=head2 Convert Palindrome

You are given a string.

Write a script to convert the given string to palindrome by adding characters in front of it.

=head3 Example 1:

Input: $str = "pinnipeds"
Output: "sdepinnipeds"

=head3 Example 2:

Input: $str = "abcd"
Output: "dcbabcd"

=head3 Example 3:

Input: $str = "bananas"
Output: "sananabananas"

=head3 Example 4:

Input: $str = "dissident"
Output: "tnedissident"

=head3 Example 5:

Input: $str = "cailliachs"
Output: "shcailliachs"

=end pod

sub is-palindrome(Str:D $s --> Bool) {
    $s eq $s.flip;
}

sub convert-palindrome(Str:D $str --> Str) {
    return $str if $str.chars < 2;
    for $str.chars...1 -> $prefix {
        return $str.flip.substr(0, $str.chars - $prefix) ~ $str if is-palindrome($str.substr(0, $prefix))
    }
}

#| create a palindrome from STR by adding characters to the front
multi MAIN(Str:D $str) {
    say convert-palindrome($str);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => "pinnipeds", output => "sdepinnipeds"));
    @tests.push(%( input => "abcd", output => "dcbabcd"));
    @tests.push(%( input => "bananas", output => "sananabananas"));
    @tests.push(%( input => "dissident", output => "tnedissident"));
    @tests.push(%( input => "cailliachs", output => "shcailliachs"));
    @tests.push(%( input => "", output => ""));
    @tests.push(%( input => "a", output => "a"));
    @tests.push(%( input => "aba", output => "aba"));

    plan @tests + 3;
    for @tests {
        is convert-palindrome(.<input>), .<output>, "{ .<input> }";
    }
    my $proc = run($*EXECUTABLE, $?FILE, 'foo', :out, :err);
    is $proc.out.slurp(:close).trim, 'oofoo', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
