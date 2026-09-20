#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

# Task 2: Knapsack Problem
# 5 boxes with weights and values:
# R: (1 kg, £1)
# B: (1 kg, £2)
# G: (2 kg, £2)
# Y: (12 kg, £4)
# P: (4 kg, £10)
# Weight limit = 15 kg.
# Find the combination that maximizes value, including bonus for fixed number of boxes.

my %WEIGHTS = ( R => 1, B => 1, G => 2, Y => 12, P => 4 );
my %VALUES  = ( R => 1, B => 2, G => 2, Y => 4,  P => 10 );
my $WEIGHT_LIMIT = 15;

sub get_combinations ( $items, $k ) {
    return ( [] ) if $k == 0;
    return ()     if !@$items || $k > @$items;

    my ( $first, @rest ) = @$items;
    my @with_first = map { [ $first, @$_ ] } get_combinations( \@rest, $k - 1 );
    my @without_first = get_combinations( \@rest, $k );

    return ( @with_first, @without_first );
}

sub solve_knapsack_fixed_k ( $boxes, $k, $limit = $WEIGHT_LIMIT ) {
    my $max_val = 0;
    my @best_combo;

    for my $combo ( get_combinations( $boxes, $k ) ) {
        my $tot_w = 0;
        my $tot_v = 0;
        for my $b (@$combo) {
            $tot_w += $WEIGHTS{$b};
            $tot_v += $VALUES{$b};
        }

        if ( $tot_w <= $limit && $tot_v > $max_val ) {
            $max_val    = $tot_v;
            @best_combo = @$combo;
        }
    }

    return ( \@best_combo, $max_val );
}

sub solve_knapsack_any ( $boxes, $limit = $WEIGHT_LIMIT ) {
    my $max_val = 0;
    my @best_combo;

    for my $k ( 1 .. scalar @$boxes ) {
        my ( $combo, $val ) = solve_knapsack_fixed_k( $boxes, $k, $limit );
        if ( $val > $max_val ) {
            $max_val    = $val;
            @best_combo = @$combo;
        }
    }

    return ( \@best_combo, $max_val );
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    my @all_boxes = qw/R B G Y P/;

    # Best overall
    my ( $best, $val ) = solve_knapsack_any( \@all_boxes );
    is( $val, 15, 'Overall optimal knapsack value is £15 (R, B, G, P)' );

    # Fixed k = 2
    my ( $best2, $val2 ) = solve_knapsack_fixed_k( \@all_boxes, 2 );
    is( $val2, 12, 'Best 2 boxes value is £12 (B, P)' );

    # Fixed k = 3
    my ( $best3, $val3 ) = solve_knapsack_fixed_k( \@all_boxes, 3 );
    is( $val3, 14, 'Best 3 boxes value is £14 (R, B, P)' );

    # Fixed k = 4
    my ( $best4, $val4 ) = solve_knapsack_fixed_k( \@all_boxes, 4 );
    is( $val4, 15, 'Best 4 boxes value is £15 (R, B, G, P)' );

    done_testing();
}
else {
    my @all_boxes = qw/R B G Y P/;
    for my $k ( 1 .. scalar @all_boxes ) {
        my ( $combo, $val ) = solve_knapsack_fixed_k( \@all_boxes, $k );
        say "Best for $k boxes: " . join( ', ', @$combo ) . " with value £$val";
    }
}
