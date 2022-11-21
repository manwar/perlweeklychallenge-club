#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

=pod

Task 2: Equal Distribution
You are given a list of integers greater than or equal to zero, @list.

Write a script to distribute the number so that each members are same. If you succeed then print the total moves otherwise print -1.

Example 1:
Input: @list = (1, 0, 5)
Output: 4

Move #1: 1, 1, 4
(2nd cell gets 1 from the 3rd cell)

Move #2: 1, 2, 3
(2nd cell gets 1 from the 3rd cell)

Move #3: 2, 1, 3
(1st cell get 1 from the 2nd cell)

Move #4: 2, 2, 2
(2nd cell gets 1 from the 3rd cell)
Example 2:
Input: @list = (0, 2, 0)
Output: -1

It is not possible to make each same.
Example 3:
Input: @list = (0, 3, 0)
Output: 2

Move #1: 1, 2, 0
(1st cell gets 1 from the 2nd cell)

Move #2: 1, 1, 1
(3rd cell gets 1 from the 2nd cell)

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
    is function( $_->{Input} ), $_->{Output}, "$_->{Name} - $_->{Input}";
}

done_testing();
