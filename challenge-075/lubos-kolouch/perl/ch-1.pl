#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

# Task 1: Coins Sum
# You are given a set of coins @C and target sum $S.
# Find how many ways you can make sum $S using coins from @C (infinite amount of each coin).

sub count_coin_ways ( $coins, $target_sum ) {
    return 1 if $target_sum == 0;
    return 0 if $target_sum < 0 || !@$coins;

    my @ways = (0) x ( $target_sum + 1 );
    $ways[0] = 1;

    for my $coin (@$coins) {
        next if $coin <= 0;
        for my $j ( $coin .. $target_sum ) {
            $ways[$j] += $ways[ $j - $coin ];
        }
    }

    return $ways[$target_sum];
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is( count_coin_ways( [ 1, 2, 4 ], 6 ),  6, 'Example 1: sum 6 with coins (1, 2, 4)' );
    is( count_coin_ways( [ 1, 5, 10 ], 12 ), 4, 'Test: sum 12 with coins (1, 5, 10)' );
    is( count_coin_ways( [ 2 ], 3 ),         0, 'Test: sum 3 with coin (2)' );
    is( count_coin_ways( [ 1, 2 ], 0 ),      1, 'Test: sum 0' );

    done_testing();
}
else {
    my $target = pop @ARGV;
    say count_coin_ways( \@ARGV, $target );
}
