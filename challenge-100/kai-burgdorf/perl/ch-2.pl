#!/usr/bin/env perl

use strict;
use warnings;

#Example 1:
#my @triangle = ( [1], [ 2, 4 ], [ 6, 4, 9 ], [ 5, 1, 7, 2 ] ); #output 8
#Example 2:
my @triangle = ( [3], [ 3, 1 ], [ 5, 2, 3 ], [ 4, 3, 1, 3 ] );    #output 7

my $lowest_sum;
get_sum_for_path();
print "lowest: $lowest_sum\n";

sub get_right_child {
    my ( $i, $j ) = @_;
    if ( defined $triangle[ $i + 1 ][ $j + 1 ] ) {
        return { is_child => 1, row => $i + 1, col => $j + 1, value => $triangle[ $i + 1 ][ $j + 1 ] };
    }
    return { is_child => 0 };
}

sub get_left_child {
    my ( $i, $j ) = @_;
    if ( defined $triangle[ $i + 1 ][$j] ) {
        return { is_child => 1, row => $i + 1, col => $j };
    }
    return { is_child => 0 };
}

sub get_sum_for_path {
    my ( $i, $j, $accu ) = @_;

    if ( !$accu ) { $accu = 0; }
    if ( !$i )    { $i    = 0; }
    if ( !$j )    { $j    = 0; }

    $accu += $triangle[$i][$j];

    my $left_child  = get_left_child( $i, $j );
    my $right_child = get_right_child( $i, $j );

    if ( $left_child->{is_child} == 0 && $right_child->{is_child} == 0 ) {    #found a leave
        if ( !$lowest_sum || $accu < $lowest_sum ) {
            $lowest_sum = $accu;
            return;
        }
    }
    else {
        get_sum_for_path( $left_child->{row},  $left_child->{col},  $accu );
        get_sum_for_path( $right_child->{row}, $right_child->{col}, $accu );
    }
}
