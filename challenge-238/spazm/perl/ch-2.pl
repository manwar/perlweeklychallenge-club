#!/usr/bin/env perl

use 5.36.0;
use Test::More;
use Data::Dumper;

=pod
    You are given an array of positive integers.

    Write a script to sort the given array in increasing order with respect to
    the count of steps required to obtain a single-digit number by multiplying
    its digits recursively for each array element. If any two numbers have the
    same count of steps, then print the smaller number first.

    Example 1
    Input: @int = (15, 99, 1, 34)
    Output: (1, 15, 34, 99)

    >>> persistence_sort([15, 99, 1, 34]) == [1, 15, 34, 99]

    15 => 1 x 5 => 5 (1 step)
    99 => 9 x 9 => 81 => 8 x 1 => 8 (2 steps)
    1  => 0 step
    34 => 3 x 4 => 12 => 1 x 2 => 2 (2 steps)
    Example 2
    Input: @int = (50, 25, 33, 22)
    Output: (22, 33, 50, 25)

    50 => 5 x 0 => 0 (1 step)
    25 => 2 x 5 => 10 => 1 x 0 => 0 (2 steps)
    33 => 3 x 3 => 9 (1 step)
    22 => 2 x 2 => 4 (1 step)
=cut

sub persistence_sort (@nums)
{
    return map { $_->[1] }
        sort   { $a->[0] <=> $b->[0] || $a->[1] <=> $b->[1] }
        map    { [ single_digit_multiplication_steps($_), $_ ] } @nums;
}

=pod
    Given a multiple-digit number, multiply its digits recursively and return
    the number of steps required to obtain a single-digit number.

    >>> single_digit_multiplication_steps(50) == 1
    >>> single_digit_multiplication_steps(25) == 2
    >>> single_digit_multiplication_steps(33) == 1
    >>> single_digit_multiplication_steps(22) == 1
    >>> single_digit_multiplication_steps(99) == 2
    >>> single_digit_multiplication_steps(81) == 1
    >>> single_digit_multiplication_steps(14) == 1
    >>> single_digit_multiplication_steps(98) == 3
    >>> single_digit_multiplication_steps(72) == 2
    >>> single_digit_multiplication_steps(14) == 1
=cut

sub single_digit_multiplication_steps ($num)
{
    my $product = 1;
    for my $digit ( split( //, "$num" ) )
    {
        $product *= int($digit);
    }

    return $product < 10
        ? 1
        : 1 + single_digit_multiplication_steps($product);
}

sub test()
{
    my $multiplication_steps_tests = [
        [ 50, 1 ], [ 25, 2 ], [ 33, 1 ], [ 22, 1 ], [ 99, 2 ], [ 81, 1 ],
        [ 98, 3 ], [ 72, 2 ], [ 14, 1 ],
    ];
    for my $test (@$multiplication_steps_tests)
    {
        my ( $input, $expected ) = @$test;
        is_deeply $expected, single_digit_multiplication_steps($input),
            "input: $input, expected: $expected";
    }
    my $persistence_sort_tests = [ [ [ 15, 99, 1, 34 ], [ 1, 15, 34, 99 ] ] ];
    for my $test (@$persistence_sort_tests)
    {
        my ( $input, $expected ) = @$test;
        my $output = [ persistence_sort(@$input) ];
        is_deeply $expected, $output,
            "input: @$input, expected: @$expected, output: @$output";
    }
    done_testing;
}

test() unless caller();
1;
