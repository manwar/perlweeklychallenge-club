#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

=pod

Task 2: Cute List
Submitted by: Mohammad S Anwar
You are given an integer, 0 < $n <= 15.

Write a script to find the number of orderings of numbers that form a cute list.

With an input @list = (1, 2, 3, .. $n) for positive integer $n, an ordering of @list is cute if for every entry, indexed with a base of 1, either

1) $list[$i] is evenly divisible by $i
or
2) $i is evenly divisible by $list[$i]
Example
Input: $n = 2
Ouput: 2

Since $n = 2, the list can be made up of two integers only i.e. 1 and 2.
Therefore we can have two list i.e. (1,2) and (2,1).

@list = (1,2) is cute since $list[1] = 1 is divisible by 1 and $list[2] = 2 is divisible by 2.

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
