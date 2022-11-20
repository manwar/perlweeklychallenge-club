#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

=pod

Task 1: Twice Largest
You are given list of integers, @list.

Write a script to find out whether the largest item in the list is at
least twice as large as each of the other items.

=cut

sub twice_as_big {
    my ( $biggest, $next_biggest ) = sort { $b <=> $a } @_;
    $biggest >= 2 * $next_biggest ? 1 : -1;
}

my @cases = (
    {
        Name   => 'Example 1',
        Input  => [ 1, 2, 3, 4 ],
        Output => -1,

        # The largest in the given list is 4. However 4 is not greater than
        # twice of every remaining elements.
        # 1 x 2 < 4
        # 2 x 2 > 4
        # 2 x 3 > 4
    },
    {
        Name   => 'Example 2',
        Input  => [ 1, 2, 0, 5 ],
        Output => 1,

        # The largest in the given list is 5. Also 5 is greater than twice of
        # every remaining elements.
        # 1 x 2 < 5
        # 2 x 2 < 5
        # 0 x 2 < 5

    },
    {
        Name   => 'Example 3',
        Input  => [ 2, 6, 3, 1 ],
        Output => 1,

        # The largest in the given list is 6. Also 6 is greater than twice of
        # every remaining elements.
        # 2 x 2 < 6
        # 3 x 2 < 6
        # 1 x 2 < 6

    },
    {
        Name   => 'Example 4',
        Input  => [ 4, 5, 2, 3 ],
        Output => -1,

        # The largest in the given list is 5. Also 5 is not greater than twice
        # of every remaining elements.
        # 4 x 2 > 5
        # 2 x 2 < 5
        # 3 x 2 > 5
    },
);

for ( @cases ) {
    is twice_as_big( $_->{Input}->@* ), $_->{Output}, $_->{Name};
}

done_testing();
