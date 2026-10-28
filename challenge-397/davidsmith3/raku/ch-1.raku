#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 397 Task 1

Submitted by: Mohammad Sajid Anwar
=head2 Absent Smallest Positive

You are given an array of integers.

Write a script to return the smallest absent positive integer such that it is strictly greater than the average of all elements in the given array.

=head3 Example 1:
Input: @arr = (1, 2, 4, 5, 6)
Output: 7

Average: (1 + 2 + 4 + 5 + 6) / 5 = 3.6
We need the smallest positive integer absent from nums that is strictly greater than 3.6.
The positive integers greater than 3.6 are 4, 5, 6, 7, ....

4 is in the given array.
5 is in the given array.
6 is in the given array.
7 is not in.

=head3 Example 2:
Input: @arr = (-5, -2, -1, 3)
Output: 1

Average: (-5 -2 -1 + 3) / 4 = -1.25
We need the smallest absent positive integer strictly greater than -1.25.
Positive integers are 1, 2, 3, 4, ... (all are strictly greater than -1.25).

1 is positive and absent from the given array.

=head3 Example 3:
Input: @arr = (1, 2, 3)
Output: 4

Average: (1 + 2 + 3) / 3 = 2.0
We need an integer strictly greater than 2.0.

3 is in the given array.
4 is not in.

=head3 Example 4:
Input: @arr = (2, 3, 7, 8)
Output: 6

Average: (2 + 3 + 7 + 8) / 4 = 5.0
We need an integer strictly greater than 5.0.

6 is not in the given array.

=head3 Example 5:
Input: @arr = (1, 1, 1, 10)
Output: 4

Average: (1 + 1 + 1 + 10) / 4 = 3.25
Positive integers strictly greater than 3.25: 4, 5, 6, ...

4 is not in the given array.

=end pod

multi absent-smallest-positive(@arr where .all ~~ Int:D && .elems > 0 --> Int) {
    my $average = @arr.sum / @arr.elems;
    my $candidate = ($average.floor + 1, 1).max;
    my $s = @arr.map({ .Int }).Set; # coerce IntStr to Int for element test
    $candidate++ while $candidate (elem) $s;
    $candidate;
}

multi absent-smallest-positive(@arr) {
    die "Unexpected input @arr[] - must be all integers and non-empty";
}

#| return the smallest positive integer greater than the average of ARR not in ARR
multi MAIN(*@arr) {
    say absent-smallest-positive(@arr);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => (1, 2, 4, 5, 6), output => 7));
    @tests.push(%( input => (-5, -2, -1, 3), output => 1));
    @tests.push(%( input => (1, 2, 3), output => 4));
    @tests.push(%( input => (2, 3, 7, 8), output => 6));
    @tests.push(%( input => (1, 1, 1, 10), output => 4));
    @tests.push(%( input => (-1,), output => 1));
    @tests.push(%( input => (0,), output => 1));
    @tests.push(%( input => (1,), output => 2));
    @tests.push(%( input => (1, 1, 1, 1, 1, 1), output => 2));
    @tests.push(%( input => (0, 1000), output => 501));

    my @should-throw;
    @should-throw.push(%( input => (1, 2, "A") ));
    @should-throw.push(%( input => () ));

    plan @tests + @should-throw + 3;
    for @tests {
        is absent-smallest-positive(.<input>), .<output>, "{ .<input>.raku }";
    }
    for @should-throw {
        throws-like { absent-smallest-positive(.<input>) }, Exception, "dies on { .<input>.raku }", message => /Unexpected/;
    }
    my $proc = run($*EXECUTABLE, $?FILE, '1', '2', '3', :out, :err);
    is $proc.out.slurp(:close).trim, '4', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
