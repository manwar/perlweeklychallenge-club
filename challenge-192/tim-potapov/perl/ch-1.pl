#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

=pod

Task 1: Binary Flip
You are given a positive integer, $n.

Write a script to find the binary flip.

=cut

sub binary_flip {
    my ( $decimal )    = @_;
    my $len            = length sprintf "%b", $decimal;
    my $biggest_binary = oct( "b" . ( 1 x $len ) );

    $biggest_binary & ~$decimal;

    # Orinally thought to just do this,
    # but couldn't figure out how to
    # get the max allowed soze: 0x7:
    #   0x7 & ~$decimal;
}

my @cases = (
    {
        Name   => 'Example 1',
        Input  => 5,
        Output => 2,
    },
    {
        Name   => 'Example 2',
        Input  => 4,
        Output => 3,
    },
    {
        Name   => 'Example 3',
        Input  => 6,
        Output => 1,
    },
    {
        Name   => 'Example 4',
        Input  => 10,
        Output => 5,
    },
    {
        Name   => 'Example 5',
        Input  => 14,
        Output => 1,
    },
    {
        Name   => 'Example 6',
        Input  => 35,
        Output => 28,
    },
);

for ( @cases ) {
    is binary_flip( $_->{Input} ), $_->{Output}, "$_->{Name} - $_->{Input}";
}

done_testing();
