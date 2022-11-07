#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

=pod

Task 1: Capital Detection
You are given a string with alphabetic characters only:
A..Z and a..z.

Write a script to find out if the usage of Capital is
appropriate if it satisfies at least one of the following rules:

1) Only first letter is capital and all others are small.
2) Every letter is small.
3) Every letter is capital.

=cut

sub is_capital {
    my ( $s ) = @_;

    0 + $s =~ /               # Make it return 0 or 1.
        ^ (?:
            
                [A-Z][a-z]* # 1) Only first letter is capital and all others are small.
            |   [a-z]+      # 2) Every letter is small.
            |   [A-Z]+      # 3) Every letter is capital.

        ) $
    /x;
}

my @cases = (
    {
        Name   => 'Example 1',
        Input  => 'Perl',
        Output => 1,
    },
    {

        Name   => 'Example 2',
        Input  => 'TPF',
        Output => 1,

    },
    {
        Name   => 'Example 3',
        Input  => 'PyThon',
        Output => 0,

    },
    {
        Name   => 'Example 4',
        Input  => 'raku',
        Output => 1,
    },
);

for ( @cases ) {
    is is_capital( $_->{Input} ), $_->{Output}, "$_->{Name} - $_->{Input}";
}

done_testing();
