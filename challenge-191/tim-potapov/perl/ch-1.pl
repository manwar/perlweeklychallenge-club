#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

=pod

Task 1: Twice Largest
Submitted by: Mohammad S Anwar
You are given list of integers, @list.

Write a script to find out whether the largest item in the list is at least twice as large as each of the other items.

Example 1
Input: @list = (1,2,3,4)
Output: -1

The largest in the given list is 4. However 4 is not greater than twice of every remaining elements.
1 x 2 < 4
2 x 2 > 4
2 x 3 > 4
Example 2
Input: @list = (1,2,0,5)
Output: 1

The largest in the given list is 5. Also 5 is greater than twice of every remaining elements.
1 x 2 < 5
2 x 2 < 5
0 x 2 < 5
Example 3
Input: @list = (2,6,3,1)
Output: 1

The largest in the given list is 6. Also 6 is greater than twice of every remaining elements.
2 x 2 < 6
3 x 2 < 6
1 x 2 < 6
Example 4
Input: @list = (4,5,2,3)
Output: -1

The largest in the given list is 5. Also 5 is not greater than twice of every remaining elements.
4 x 2 > 5
2 x 2 < 5
3 x 2 > 5

=cut

sub function {
    my ( $input ) = @_;

}

my @cases = (
    {
        Name   => 'Example1',
        Input  => 1,
        Output => 1,
    },
);

for ( @cases ) {
    is function($_->{Input} ), $_->{Output}, "$_->{Name} - $_->{Input}";
}

done_testing();
