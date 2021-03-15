#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use List::Util qw(min);

{
    test_triangle_sum();
}

sub test_triangle_sum() {

    my @test_cases = (
        [ [ [1], [ 2, 4 ], [ 6, 4, 9 ], [ 5, 1, 7, 2 ] ], 8 ],
        [ [ [3], [ 3, 1 ], [ 5, 2, 3 ], [ 4, 3, 1, 3 ] ], 7 ]
    );

    require Test::More;
    Test::More->import( tests => scalar @test_cases );

    for my $test (@test_cases) {
        my ( $triangle, $expected_sum ) = @{$test};
        ok(
            triangle_sum($triangle) == $expected_sum,
            "The minimum path is $expected_sum"
        );
    }
}

sub triangle_sum ( $triangle, $pos = 0 ) {
    my ( $cur, @rest ) = @$triangle;
    return 0 if !$cur;

    return $cur->[$pos] +
      min( triangle_sum( \@rest, $pos ), triangle_sum( \@rest, $pos + 1 ), );
}
