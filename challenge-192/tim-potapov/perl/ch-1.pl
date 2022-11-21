#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

=pod

Task 1: Binary Flip
You are given a positive integer, $n.

Write a script to find the binary flip.

Example 1
Input: $n = 5
Output: 2

First find the binary equivalent of the given integer, 101.
Then flip the binary digits 0 -> 1 and 1 -> 0 and we get 010.
So Binary 010 => Decimal 2.
Example 2
Input: $n = 4
Output: 3

Decimal 4 = Binary 100
Flip 0 -> 1 and 1 -> 0, we get 011.
Binary 011 = Decimal 3
Example 3
Input: $n = 6
Output: 1

Decimal 6 = Binary 110
Flip 0 -> 1 and 1 -> 0, we get 001.
Binary 001 = Decimal 1

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
