#!/usr/bin/env perl
#
# Week 073 task 1
# Min Sliding Window
# You are given an array of integers @A and sliding window size $S.
# Write a script to create an array of min from each sliding window.

use strict;
use warnings;
use feature qw/ say /;
use Test::More;

my @array_test = ( 1, 5, 0, 2, 9, 3, 7, 6, 4, 8 );
my $size_test  = 3;
my @expected   = ( 0, 0, 0, 2, 3, 3, 4, 4 );
is_deeply( get_min_sliding_window( \@array_test, $size_test ), \@expected );
done_testing();

sub get_min_sliding_window {
    my $array_ref = shift;
    my $size      = shift;
    my @array     = @{$array_ref};
    my @result;
    my $index = 0;
    while ( $index <= ( scalar @array - $size ) ) {
        my @slice_sorted = sort @array[ $index .. ( $index + $size - 1 ) ];
        push @result, $slice_sorted[0];
        $index++;
    }
    return \@result;
}

