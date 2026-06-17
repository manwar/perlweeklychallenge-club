#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 378 Task 1

Submitted by: Mohammad Sajid Anwar
=head2 Second Largest Digit

You are given an alphanumeric string.

Write a script to find the second largest distinct digit in the given string. Return -1 if none found.

=head3 Example 1:

Input: $str = "aaaaa77777"
Output: -1

The only digit in the given string is 7 and there is no second digit.

=head3 Example 2:

Input: $str = "abcde"
Output: -1

No numerical digits in the given string.

=head3 Example 3:

Input: $str = "9zero8eight7seven9"
Output: 8

=head3 Example 4:

Input: $str = "xyz9876543210"
Output: 8

=head3 Example 5:

Input: $str = "4abc4def2ghi8jkl2"
Output: 4

=end pod

sub second-largest-digit(Str:D $str --> Int) {
    my @distinct = $str.comb(/ \d /).unique.sort;
    return -1 if @distinct.elems < 2;
    +@distinct[*-2];
}

#| find the second largest distinct digit in str
multi MAIN(Str:D $str) {
    say second-largest-digit($str);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => "aaaaa77777", output => -1 ));
    @tests.push(%( input => "abcde", output => -1 ));
    @tests.push(%( input => "9zero8eight7seven9", output => 8 ));
    @tests.push(%( input => "xyz9876543210", output => 8 ));
    @tests.push(%( input => "4abc4def2ghi8jkl2", output => 4 ));

    @tests.push(%( input => "", output => -1 ));
    @tests.push(%( input => "77", output => -1 ));
    @tests.push(%( input => "78", output => 7 ));
    @tests.push(%( input => "7788", output => 7 ));
    @tests.push(%( input => "!!!!ABCD123", output => 2 ));
    @tests.push(%( input => "123!!!!ABCD", output => 2 ));

    plan @tests + 3;
    for @tests {
        is second-largest-digit(.<input>), .<output>, "{ .<input> }";
    }

    my $proc = run($*EXECUTABLE, $?FILE, '123', :out, :err);
    is $proc.out.slurp(:close).trim, '2', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
