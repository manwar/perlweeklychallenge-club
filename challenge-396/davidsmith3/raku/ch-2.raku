#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 396 Task 2

Submitted by: Mohammad Sajid Anwar
=head2 Trionic Array

You are given an array of integer.

Write a script to return true if the given array is Trionic otherwise return false.

An array is trionic if there exist indices 0 < p < q < n − 1 such that arr[0…p] is strictly increasing, arr[p…q] is strictly decreasing, and arr[q…n − 1] is strictly increasing.

=head3 Example 1:

Input: @arr = (1, 3, 5, 4, 2, 6, 8)
Output: true

Choose p = 2 and q = 4
$arr[0..2] = (1, 3, 5) (strictly increasing)
$arr[2..4] = (5, 4, 2) (strictly decreasing)
$arr[4..6] = (2, 6, 8) (strictly increasing)

Valid indices: 0 < p (2) < q (4) < n-1 (6).

=head3 Example 2:

Input: @arr = (1, 4, 4, 2, 1, 3, 5)
Output: false

The first segment (1, 4, 4) contains duplicate adjacent values, so it is not strictly increasing.
No valid p and q exist to satisfy all three strictly monotonic conditions.

=head3 Example 3:

Input: @arr = (2, 10, 3, 1, 9)
Output: true

Choose p = 1 and q = 3.
$arr[0..1] = (2, 10)    (strictly increasing)
$arr[1..3] = (10, 3, 1) (strictly decreasing)
$arr[3..4] = (1, 9)     (strictly increasing)

=head3 Example 4:

Input: @arr = (1, 2, 3, 4, 3, 2, 1)
Output: false

This is a standard mountain array (strictly increasing, then strictly decreasing).
There is no second valley (q) that transitions back into a strictly increasing third segment before reaching the end of the array.

=head3 Example 5:

Input: @arr = (1, 3, 6, 4, 2, 7, 8, 4)
Output: false

=end pod

multi trionic(@arr where .all ~~ Int:D --> Bool) {
    return False if @arr.elems < 4;

    my $p = run-last-idx(@arr, 0, &[<]);
    return False if $p == 0 || $p == @arr.elems - 1;

    my $q = run-last-idx(@arr, $p, &[>]);
    return False if $q == @arr.elems - 1;

    return run-last-idx(@arr, $q, &[<]) == @arr.elems - 1;
}

multi trionic(@arr) {
    die "Unexpected input {@arr}";
}

sub run-last-idx(@arr, Int:D $start-index, &op --> Int) {
    my $i = $start-index;
    $i++ while $i < @arr.elems-1 && &op(@arr[$i], @arr[$i+1]);
    $i;
}

#| determine if ARR is trionic
multi MAIN(*@arr) {
    say trionic(@arr);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => (1, 3, 5, 4, 2, 6, 8), output => True));
    @tests.push(%( input => (1, 4, 4, 2, 1, 3, 5), output => False));
    @tests.push(%( input => (2, 10, 3, 1, 9), output => True));
    @tests.push(%( input => (1, 2, 3, 4, 3, 2, 1), output => False));
    @tests.push(%( input => (1, 3, 6, 4, 2, 7, 8, 4), output => False));
    @tests.push(%( input => (1, 2, 1, 2), output => True));
    @tests.push(%( input => (), output => False));
    @tests.push(%( input => (1, ), output => False));
    @tests.push(%( input => (3, 2, 1, 2), output => False));
    @tests.push(%( input => (4, 3, 2, 1), output => False));
    @tests.push(%( input => (1, 2, 3, 4), output => False));

    my @should-throw;
    @should-throw.push(%( input => (1, 2, 3, "A") ));

    plan @tests + @should-throw + 3;
    for @tests {
        is trionic(.<input>), .<output>, "{ .<input>.raku }";
    }
    for @should-throw {
        throws-like { trionic(.<input>) }, Exception, "dies on { .<input>.raku }", message => /Unexpected/;
    }
    my $proc = run($*EXECUTABLE, $?FILE, '10', '20', '15', '20', :out, :err);
    is $proc.out.slurp(:close).trim, 'True', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
