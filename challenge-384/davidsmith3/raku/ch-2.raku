#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 384 Task 2

Submitted by: Mohammad Sajid Anwar
=head2 Special Binary Substrings

You are given a binary string.

Write a script to return all non-empty substrings (distinct) that have the same number of 0’s and 1’s, and all the 0’s and all the 1’s in these substrings are grouped consecutively.

=head3 Example 1:

Input: $binary = "0101"
Output: ("01", "10")

=head3 Example 2:

Input: $binary = "000111"
Output: ("000111", "0011", "01")

=head3 Example 3:

Input: $binary = "000011"
Output:  ("0011", "01")

=head3 Example 4:

Input: $binary = "10011100"
Output: ("10", "0011", "01", "1100")

=head3 Example 5:

Input: $binary = "00000"
Output: ()

=end pod

sub special-binary-substrings(Str:D $binary where / ^ <[01]>+ $ / --> List) {
    $binary.match(:ov, / [(0+) (1+) | (1+) (0+)] <?{$0.chars == $1.chars}> /).map({ .Str }).unique.List;
}

#| return special binary substrings of binary string BINARY
multi MAIN(Str:D $binary) {
    say special-binary-substrings($binary);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => "0101", output => ("01", "10") ));
    @tests.push(%( input => "000111", output => ("000111", "0011", "01") ));
    @tests.push(%( input => "000011", output => ("0011", "01") ));
    @tests.push(%( input => "10011100", output => ("10", "0011", "01", "1100") ));
    @tests.push(%( input => "00000", output => () ));
    @tests.push(%( input => "0", output => () ));
    @tests.push(%( input => "1", output => () ));
    @tests.push(%( input => "01", output => ("01") ));
    @tests.push(%( input => "10", output => ("10") ));
    @tests.push(%( input => "101", output => ("10", "01") ));
    @tests.push(%( input => "1011", output => ("10", "01") ));
    @tests.push(%( input => "111000", output => ("111000", "1100", "10") ));
    my @should-throw;
    @should-throw.push(%( input => "" ));
    @should-throw.push(%( input => "abc" ));
    @should-throw.push(%( input => "012" ));

    plan @tests + @should-throw + 3;
    for @tests {
        is-deeply special-binary-substrings(.<input>).sort, .<output>.sort, "{ .<input> }";
    }
    for @should-throw {
        dies-ok { special-binary-substrings(.<input>) }, "dies on { .<input> }";
    }
    my $proc = run($*EXECUTABLE, $?FILE, '01', :out, :err);
    is $proc.out.slurp(:close).trim, '(01)', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
