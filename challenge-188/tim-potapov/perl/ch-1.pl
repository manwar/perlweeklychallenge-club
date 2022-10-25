#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

=pod

 TASK #1: Divisible Pairs
 
 You are given list of integers @list of size $n and divisor $k.
 Write a script to find out count of pairs in the given list that
 satisfies the rules i.e The pair (i, j) is eligible if and only if:

        0 <= i < j < len(list)
    and list[i] + list[j] is divisible by k

=cut

sub DivisiblePairsCount {
    my ( $list, $divisor ) = @_;
    my $count = 0;

    while ( @$list > 1 ) {
        my $n = shift @$list;
        for ( @$list ) {
            if ( 0 == ( $n + $_ ) % $divisor ) {
                $count++;
            }
        }
    }

    $count;
}

my @cases = (
    {
        Name    => 'Example 1',
        List    => [ 4, 5, 1, 6 ],
        Divisor => 2,
        Output  => 2,
    },

    {
        Name    => 'Example 2',
        List    => [ 1, 2, 3, 4 ],
        Divisor => 2,
        Output  => 2,
    },

    {
        Name    => 'Example 3',
        List    => [ 1, 3, 4, 5 ],
        Divisor => 3,
        Output  => 2,
    },

    {
        Name    => 'Example 4',
        List    => [ 5, 1, 2, 3 ],
        Divisor => 4,
        Output  => 2,
    },

    {
        Name    => 'Example 5',
        List    => [ 7, 2, 4, 5 ],
        Divisor => 4,
        Output  => 1,
    },

);

for ( @cases ) {
    is( DivisiblePairsCount( $_->{List}, $_->{Divisor} ),
        $_->{Output}, $_->{Name} );
}

done_testing();
