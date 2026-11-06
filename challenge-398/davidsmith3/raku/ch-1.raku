#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 398 Task 1

Submitted by: Mohammad Sajid Anwar
=head2 Divisible Average
You are given an array of positive integers.

Write a script to return the closest integer to the mean value of all even integers that are divisible by 3. If none is divisible, return 0.

=head3 Example 1:

Input: @arr = (18, 5, 7, 11)
Output: 18

18 is the only even number and divisible by 3.
Average: 18 / 1 = 18.

=head3 Example 2:

Input: @arr = (6, 12, 18, 24, 30, 40)
Output: 18

The qualifying numbers are 6, 12, 18, 24, and 30.
Average: (6 + 12 + 18 + 24 + 30) / 5 = 90 / 5 = 18

=head3 Example 3:

Input: @arr = (3, 9, 15, 21, 27)
Output: 0

None of the elements are even.
Since no elements qualify, return 0.

=head3 Example 4:

Input: @arr = (6, 12, 14, 20)
Output: 9

The qualifying numbers are 6 and 12.
Average: (6 + 12) / 2 = 9.

=head3 Example 5:

Input: @arr = (6, 6, 6, 12, 12)
Output: 8

All five numbers are even and divisible by 3.
Average: (6 + 6 + 6 + 12 + 12) / 5 = 8.4 => 8

=end pod

multi divisible-average(@arr where .all ~~ Int:D && .all > 0 --> Int) {
    my @eligible = @arr.grep({ $_ %% 6 });
    return 0 if @eligible.elems == 0;
    (@eligible.sum / @eligible.elems).round;
}

multi divisible-average(@arr) {
    die "Unexpected input @arr[] - must be all positive integers";
}

#| return closest integer to mean value of all integers in ARR that are divisible by six
multi MAIN(*@arr) {
    say divisible-average(@arr);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => (18, 5, 7, 11), output => 18));
    @tests.push(%( input => (6, 12, 18, 24, 30, 40), output => 18));
    @tests.push(%( input => (3, 9, 15, 21, 27), output => 0));
    @tests.push(%( input => (6, 12, 14, 20), output => 9));
    @tests.push(%( input => (6, 6, 6, 12, 12), output => 8));
    @tests.push(%( input => (), output => 0));
    @tests.push(%( input => (6,), output => 6));
    @tests.push(%( input => (6, 6), output => 6));
    @tests.push(%( input => (6, 12), output => 9));
    @tests.push(%( input => (1, 2, 3, 4, 5, 6), output => 6));
    @tests.push(%( input => (6, 12, 12, 12, 12), output => 11));
    @tests.push(%( input => (6, 12, 12, 12, 12, 12, 12), output => 11));
    @tests.push(%( input => (6, 6, 6, 12), output => 8));
    @tests.push(%( input => (6, 6, 6, 24), output => 11));

    my @should-throw;
    @should-throw.push(%( input => ("A",) ));
    @should-throw.push(%( input => (0,) ));
    @should-throw.push(%( input => (-1,) ));

    plan @tests + @should-throw + 3;
    for @tests {
        is divisible-average(.<input>), .<output>, "{ .<input>.raku }";
    }
    for @should-throw {
        throws-like { divisible-average(.<input>) }, Exception, "dies on { .<input>.raku }", message => /Unexpected/;
    }
    my $proc = run($*EXECUTABLE, $?FILE, '6', :out, :err);
    is $proc.out.slurp(:close).trim, '6', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
