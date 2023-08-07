#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

sub array_degree {
    my @array = @_;
    my %count;
    my %start;
    my %end;

    # Determine the frequency of each element and the start and end indices
    for my $i ( 0 .. $#array ) {
        my $num = $array[$i];
        $count{$num}++;
        $start{$num} //= $i;
        $end{$num} = $i;
    }

    # Find the degree of the array
    my $degree = 0;
    for my $num ( keys %count ) {
        $degree = $count{$num} if $count{$num} > $degree;
    }

    # Find the smallest slice with the same degree
    my $min_length = @array;
    my @result;
    for my $num ( keys %count ) {
        if ( $count{$num} == $degree ) {
            my $length = $end{$num} - $start{$num} + 1;
            if ( $length < $min_length ) {
                $min_length = $length;
                @result     = @array[ $start{$num} .. $end{$num} ];
            }
        }
    }

    return @result;
}

is_deeply( [ array_degree( 1, 3, 3, 2 ) ],    [ 3, 3 ],       'Example 1' );
is_deeply( [ array_degree( 1, 2, 1, 3 ) ],    [ 1, 2, 1 ],    'Example 2' );
is_deeply( [ array_degree( 1, 3, 2, 1, 2 ) ], [ 2, 1, 2 ],    'Example 3' );
is_deeply( [ array_degree( 1, 1, 2, 3, 2 ) ], [ 1, 1 ],       'Example 4' );
is_deeply( [ array_degree( 2, 1, 2, 1, 1 ) ], [ 1, 2, 1, 1 ], 'Example 5' );

done_testing();
