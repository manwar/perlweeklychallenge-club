#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 379 Task 2

Submitted by: Mohammad Sajid Anwar
=head2 Armstrong Number

You are given two integers, $base and $limit.

Write a script to find all Armstrong numbers in base $base that are less than $limit.

If raising each of the digits of a nonnegative integer to the power of the total number of digits, then taking the sum, equals the original number, it is an Armstrong number.

=head3 Example 1:
Input: $base = 10, $limit = 1000
Output: (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407)

=head3 Example 2:

Input: $base = 7, $limit = 1000
Output: (0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250)

=head3 Example 3:

Input: $base = 16, $limit = 1000
Output: (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 342, 371, 520, 584, 645)

=end pod

sub get-base(Int:D $i, Int:D $base --> Array) {
    my @result;
    my $curr = $i;
    loop {
        my $d = $curr div $base;
        my $m = $curr mod $base;
        last if $d == 0;
        @result.push($m);
        $curr = $d;
    }
    @result.push($curr);
    @result.reverse.Array;
}

sub armstrong-numbers(Int:D $base where * >= 2, Int:D $limit where * >= 0 --> Array) {
    my @result;
    for 0..^$limit -> $i {
        my @rebased = get-base($i, $base);
        my $num-digits = @rebased.elems;
        my $sum = @rebased.map({ $_ ** $num-digits }).sum;
        @result.push($i) if $sum == $i;
    }
    @result;
}

#| find armstrong numbers with base base and base-10 limit
multi MAIN(Int:D $base, Int:D $limit) {
    say armstrong-numbers($base, $limit);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => (10, 1000), output => [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407] ));
    @tests.push(%( input => (7, 1000), output => [0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250] ));
    @tests.push(%( input => (16, 1000), output => [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 342, 371, 520, 584, 645] ));
    @tests.push(%( input => (10, 5), output => [0, 1, 2, 3, 4] ));
    @tests.push(%( input => (10, 0), output => [] ));
    @tests.push(%( input => (10, 2), output => [0, 1] ));
    @tests.push(%( input => (33, 3), output => [0, 1, 2] ));
    @tests.push(%( input => (2, 3), output => [0, 1] ));

    my @base-tests;
    @base-tests.push(%( input => (0, 10), output =>  [0] ));
    @base-tests.push(%( input => (0, 2), output =>  [0] ));
    @base-tests.push(%( input => (10, 10), output =>  [1, 0] ));
    @base-tests.push(%( input => (2, 2), output =>  [1, 0] ));
    @base-tests.push(%( input => (1, 10), output =>  [1] ));
    @base-tests.push(%( input => (1, 2), output =>  [1] ));
    @base-tests.push(%( input => (17, 10), output =>  [1, 7] ));
    @base-tests.push(%( input => (18, 16), output =>  [1, 2] ));
    @base-tests.push(%( input => (19, 2), output =>  [1, 0, 0, 1, 1] ));
    @base-tests.push(%( input => (19, 64), output =>  [19] ));

    plan @tests + @base-tests + 3;
    for @tests {
        is-deeply armstrong-numbers(|.<input>), .<output>, "{ .<input> }";
    }
    for @base-tests {
        is-deeply get-base(|.<input>), .<output>, "get-base: { .<input> }";
    }
    my $proc = run($*EXECUTABLE, $?FILE, '2', '3', :out, :err);
    is $proc.out.slurp(:close).trim, '[0 1]', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
