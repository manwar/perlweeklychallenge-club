#!/usr/bin/env perl

use 5.36.0;
use Test::More;

=pod
    You are given an array of integers.

    Write a script to return the running sum of the given array.
    The running sum can be calculated as sum[i] = num[0] + num[1] + …. + num[i]

    Example 1
    Input: @int = (1, 2, 3, 4, 5)
    Output: (1, 3, 6, 10, 15)
    >>> assert (1, 3, 6, 10, 15) == running_sum([1, 2, 3, 4, 5])
    Example 2
    Input: @int = (1, 1, 1, 1, 1)
    Output: (1, 2, 3, 4, 5)
    >>> assert (1, 2, 3, 4, 5) == running_sum([1, 1, 1, 1, 1])
    Example 3
    Input: @int = (0, -1, 1, 2)
    Output: (0, -1, 0, 2)
    >>> assert ( 0, -1, 0, 2) == running_sum([0, -1, 1, 2])
=cut

sub running_sum (@nums)
{
    my $current_sum = 0;
    my @running_sum = ();
    for my $i (@nums)
    {
        $current_sum += $i;
        push @running_sum, $current_sum;
    }
    return @running_sum;
}

sub test()
{
    my $tests = [
        [ [ 1, 2, 3, 4, 5 ], [ 1, 3, 6, 10, 15 ] ],
        [ [ 1, 1, 1, 1, 1 ], [ 1, 2, 3, 4,  5 ] ],
        [ [ 0, -1, 1, 2 ], [ 0, -1, 0, 2 ] ],
    ];
    for my $test (@$tests)
    {
        my ( $input, $expected ) = @$test;
        is_deeply [ running_sum(@$input) ], $expected,
            "input: @$input, expected: @$expected";
    }
    done_testing();
}

test() if not caller();
1;
