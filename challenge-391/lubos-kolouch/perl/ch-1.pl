#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

# Task 1: Median of Arrays
# Merge two sorted arrays and return the median as a float.

sub find_median_sorted_arrays ( $arr1, $arr2 ) {
    my @merged;
    my $i = 0;
    my $j = 0;
    my $n = scalar @$arr1;
    my $m = scalar @$arr2;

    while ( $i < $n && $j < $m ) {
        if ( $arr1->[$i] <= $arr2->[$j] ) {
            push @merged, $arr1->[ $i++ ];
        }
        else {
            push @merged, $arr2->[ $j++ ];
        }
    }

    while ( $i < $n ) {
        push @merged, $arr1->[ $i++ ];
    }
    while ( $j < $m ) {
        push @merged, $arr2->[ $j++ ];
    }

    my $total = scalar @merged;
    die "Both arrays are empty" if $total == 0;

    if ( $total % 2 == 1 ) {
        return sprintf( "%.1f", $merged[ int( $total / 2 ) ] ) + 0.0;
    }
    else {
        my $mid = $total / 2;
        my $val = ( $merged[ $mid - 1 ] + $merged[$mid] ) / 2.0;
        return sprintf( "%.1f", $val ) + 0.0;
    }
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is( find_median_sorted_arrays( [2], [4] ), 3.0, 'Example 1' );
    is( find_median_sorted_arrays( [ 1, 2, 3 ], [ 7, 8, 9, 10 ] ), 7.0, 'Example 2' );
    is( find_median_sorted_arrays( [], [ 10, 20, 30, 40 ] ), 25.0, 'Example 3' );
    is( find_median_sorted_arrays( [100], [ 1, 2, 3, 4, 5, 6, 7 ] ), 4.5, 'Example 4' );
    is( find_median_sorted_arrays( [ 1, 2, 2 ], [ 2, 2, 3 ] ), 2.0, 'Example 5' );

    done_testing();
}
else {
    say "Run via embedded tests.";
}
