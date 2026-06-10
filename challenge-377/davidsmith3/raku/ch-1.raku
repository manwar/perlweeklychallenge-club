#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 377 Task 1

Submitted by: Mohammad Sajid Anwar
=head2 Reverse Existence

You are given a string.

Write a script to find whether any substring of length 2 is also present in the reverse of the given string.

=head3 Example 1:

Input: $str = "abcba"
Output: true

Reverse of given string is "abcba".
The substring "ab" in original string is also present in the reverse string too.

=head3 Example 2:

Input: $str = "racecar"
Output: true

The substring "ce" is present in both.

=head3 Example 3:

Input: $str = "abcd"
Output: false

=head3 Example 4:

Input: $str = "banana"
Output: true

The substring "an" is present in both.

=head3 Example 5:

Input: $str = "hello"
Output: true

The substring "ll" is present in both.

=end pod

sub reverse-existence(Str:D $str --> Bool) {
    my $str_lc = $str.lc;
    my $str_rev = $str_lc.flip;
    $str_lc.comb.rotor(2 => -1).grep({ $str_rev.contains($_.join) }).so;
}

#| Determine if a substring of length two of str exists in the reverse of str
multi MAIN(Str:D $str) {
    say reverse-existence($str);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => "abcba", output => True ));
    @tests.push(%( input => "racecar", output => True ));
    @tests.push(%( input => "abcd", output => False ));
    @tests.push(%( input => "banana", output => True ));
    @tests.push(%( input => "hello", output => True ));

    @tests.push(%( input => "", output => False ));
    @tests.push(%( input => "a", output => False ));
    @tests.push(%( input => "aa", output => True ));
    @tests.push(%( input => "ab", output => False ));
    @tests.push(%( input => "AbBa", output => True ));
    plan @tests + 3;
    for @tests {
        is reverse-existence(.<input>), .<output>, "{ .<input> }";
    }
    my $proc = run($*EXECUTABLE, $?FILE, "abcba", :out, :err);
    is $proc.out.slurp(:close).trim, 'True', "cli produces produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
