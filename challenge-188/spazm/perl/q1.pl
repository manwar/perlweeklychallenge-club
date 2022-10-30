#!/usr/bin/env perl
use v5.30.0;

=pod

You are given list of integers @list of size $n and divisor $k.

Write a script to find out count of pairs in the given list that satisfies the following rules.

    The pair (i, j) is eligible if and only if
    a) 0 <= i < j < len(list)
    b) list[i] + list[j] is divisible by k

=cut

=pod

Solution uses O(n) space to minimize the use of mod calculation from O(n^2) to O(n).
This space could be saved by overwriting the input array.

=cut

sub count_matching_pairs
{
    my ( $input, $size_n, $div_k ) = @_;

    my @mods = map { $_ % $div_k } @$input;

    my $count = 0;

    for my $i ( 0 .. @$input - 1 )
    {
        for my $j ( $i + 1 .. @$input - 1 )
        {
            my $test = $mods[$i] + $mods[$j];
            if ( $test == 0 or $test == $div_k )
            {
                $count++;
            }
        }
    }
    return $count;
}

use Test::More;
my $test_data = [
    [ [ 4, 5, 1, 6 ], 2 => 2 ],
    [ [ 1, 2, 3, 4 ], 2 => 2 ],
    [ [ 1, 3, 4, 5 ], 3 => 2 ],
    [ [ 5, 1, 2, 3 ], 4 => 2 ],
    [ [ 7, 2, 4, 5 ], 4 => 1 ],
];
for my $test (@$test_data)
{
    my ( $in, $k, $expected ) = @$test;
    is count_matching_pairs( $in, length(@$in), $k ), $expected;
}
done_testing;
