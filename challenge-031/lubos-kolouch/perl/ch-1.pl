#!/usr/bin/env perl
use v5.38;
use warnings;
use Try::Tiny;

# Task 1: Create a function to check divide by zero error without checking if denominator is zero.

sub divide_test ( $num, $div ) {
    my $result;

    try {
        $result = $num / $div;
    }
    catch {
        $result = "ERROR";
    };

    return $result;
}

# TESTS
use Test::More;

is( divide_test( 0, 0 ), "ERROR", "0 / 0 results in ERROR" );
is( divide_test( 1, 0 ), "ERROR", "1 / 0 results in ERROR" );
is( divide_test( 1, 1 ), 1,       "1 / 1 results in 1" );
is( divide_test( 6, 2 ), 3,       "6 / 2 results in 3" );

done_testing;
