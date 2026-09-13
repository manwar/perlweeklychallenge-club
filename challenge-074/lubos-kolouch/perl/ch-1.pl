#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

# Task 1: Majority Element
# Find the majority element in the array which appears more than floor(size/2) times.
# Return -1 if no majority element is found.

sub get_majority_element ($arr) {
    return -1 if !@$arr;

    my %counts;
    my $threshold = int( scalar(@$arr) / 2 );

    for my $val (@$arr) {
        $counts{$val}++;
        return $val if $counts{$val} > $threshold;
    }

    return -1;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is( get_majority_element( [ 1, 2, 2, 3, 2, 4, 2 ] ), 2,  'Example 1' );
    is( get_majority_element( [ 1, 3, 1, 2, 4, 5 ] ),    -1, 'Example 2' );

    is( get_majority_element( [7] ),                     7,  'Single element' );
    is( get_majority_element( [] ),                      -1, 'Empty array' );

    done_testing();
}
else {
    say get_majority_element( \@ARGV );
}
