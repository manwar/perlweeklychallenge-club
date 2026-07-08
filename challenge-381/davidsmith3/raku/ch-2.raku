#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 381 Task 2

Submitted by: Mohammad Sajid Anwar
=head2 Smaller Greater Element

You are given an array of integers.

Write a script to find the number of elements that have both a strictly smaller and greater element in the given array.

=head3 Example 1:

Input: @int = (2,4)
Output: 0

Not enough elements in the array.

=head3 Example 2:

Input: @int = (1, 1, 1, 1)
Output: 0

=head3 Example 3:

Input: @int = (1, 1, 4, 8, 12, 12)
Output: 2

The elements are 4 and 8.

=head3 Example 4:

Input: @int = (3, 6, 6, 9)
Output: 2

Both instances of 6.

=head3 Example 5:

Input: @int = (0, -5, 10, -2, 4)
Output: 3

The elements are 0, -2, and 4.

=end pod

sub remove-left(@array where .all ~~ Int --> Array) {
    my @a = @array;
    return @a if @a.elems == 0;
    @a.shift while @a.elems > 2 && @a[0] == @a[1];
    @a.shift;
    @a;
}

sub smaller-greater-element(@array where .all ~~ Int --> Int) {
    return 0 if @array.unique.elems < 3;
    @array.sort.&remove-left.reverse.&remove-left.elems;
}

#| determine number of elements of array with smaller and greater elements
multi MAIN(*@array) {
    say smaller-greater-element(@array);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => (2, 4), output => 0 ));
    @tests.push(%( input => (1, 1, 1, 1), output => 0 ));
    @tests.push(%( input => (1, 1, 4, 8, 12, 12), output => 2 ));
    @tests.push(%( input => (3, 6, 6, 9), output => 2 ));
    @tests.push(%( input => (0, -5, 10, -2, 4), output => 3 ));
    @tests.push(%( input => (1, ), output => 0 ));
    @tests.push(%( input => (1, 2, 2, 2), output => 0 ));
    @tests.push(%( input => (1, 2, 2, 3), output => 2 ));
    @tests.push(%( input => (2, 2, 2, 3), output => 0 ));
    @tests.push(%( input => (1, 2, 3), output => 1 ));
    my @should-throw;
    @should-throw.push(%( input => ("a", 1) ));
    my @test-squish;
    @test-squish.push(%( input => [0, 0, 0, 0, 0, 0, 1], output => [1] ));
    @test-squish.push(%( input => [0, 0, 1], output => [1] ));
    @test-squish.push(%( input => [0, 1], output => [1] ));
    @test-squish.push(%( input => [1], output => [] ));
    @test-squish.push(%( input => [], output => [] ));

    plan @tests + @should-throw + @test-squish + 3;
    for @tests {
        is smaller-greater-element(.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        dies-ok { smaller-greater-element(.<input>) }, "dies on { .<input> }";
    }
    for @test-squish {
        is-deeply remove-left(.<input>), .<output>, "{ .<input> }";
    }
    my $proc = run($*EXECUTABLE, $?FILE, '1', '2', '3', :out, :err);
    is $proc.out.slurp(:close).trim, '1', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
