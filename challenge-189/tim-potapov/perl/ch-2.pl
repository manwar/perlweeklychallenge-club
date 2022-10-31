#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use List::Util      qw( max );
use List::MoreUtils qw( first_index last_index );

=pod

 Task 2: Array Degree
 You are given an array of 2 or more
 non-negative integers.
 
 Write a script to find out the smallest slice,
 i.e. contiguous subarray of the original array,
 having the degree of the given array.
 
 The degree of an array is the maximum frequency
 of an element in the array.

=cut

sub smallest_slice_of_degree {
    my ( $array ) = @_;

    my %frequency;
    $frequency{$_}++ for @$array;

    my $degree = max values %frequency;

    my @nums =
      grep { $frequency{$_} == $degree }
      keys %frequency;

    my @smallest_slice;
    for my $num ( @nums ) {
        my $i1    = first_index { $_ == $num } @$array;
        my $i2    = last_index  { $_ == $num } @$array;
        my @slice = @$array[ $i1 .. $i2 ];
        if ( !@smallest_slice or @slice < @smallest_slice ) {
            @smallest_slice = @slice;
        }
    }

    \@smallest_slice;
}

my @cases = (

    # The degree of the given array is 2.
    # The possible subarrays having the degree 2
    # are as below:
    # (3, 3)
    # (1, 3, 3)
    # (3, 3, 2)
    # (1, 3, 3, 2)
    # And the smallest of all is (3, 3).
    {
        Name   => 'Example 1',
        Input  => [ 1, 3, 3, 2 ],
        Output => [ 3, 3 ],
    },
    {
        Name   => 'Example 2',
        Input  => [ 1, 2, 1, 3 ],
        Output => [ 1, 2, 1 ],
    },
    {
        Name   => 'Example 3',
        Input  => [ 1, 3, 2, 1, 2 ],
        Output => [ 2, 1, 2 ],
    },
    {
        Name   => 'Example 4',
        Input  => [ 1, 1, 2, 3, 2 ],
        Output => [ 1, 1 ],
    },
    {
        Name   => 'Example 5',
        Input  => [ 2, 1, 2, 1, 1 ],
        Output => [ 1, 2, 1, 1 ],
    },
);

for ( @cases ) {
    my $output = smallest_slice_of_degree( $_->{Input} );
    is_deeply $output, $_->{Output}, $_->{Name};
}

done_testing();
