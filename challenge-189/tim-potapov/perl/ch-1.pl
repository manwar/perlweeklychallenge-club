#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use List::Util qw( minstr );

=pod

 Task 1: Greater Character
 You are given an array of characters (a..z)
 and a target character.
 
 Write a script to find out the smallest
 character in the given array lexicographically
 greater than the target character.

=cut

sub greater_char {
    my ( $array, $target ) = @_;
    minstr(grep { $_ gt $target } @$array) // $target;
}

my @cases = (
    {
        Name   => 'Example 1',
        Array  => [qw/e m u g/],
        Target => 'b',
        Output => 'e',
    },
    {
        Name   => 'Example 2',
        Array  => [qw/d c e f/],
        Target => 'a',
        Output => 'c',
    },
    {
        Name   => 'Example 3',
        Array  => [qw/j a r/],
        Target => 'o',
        Output => 'r',
    },
    {
        Name   => 'Example 4',
        Array  => [qw/d c a f/],
        Target => 'a',
        Output => 'c',
    },
    {
        Name   => 'Example 5',
        Array  => [qw/t g a l/],
        Target => 'v',
        Output => 'v',
    },
);

for ( @cases ) {
    my $output = greater_char( @$_{qw/ Array Target /} );
    is $output, $_->{Output}, $_->{Name};
}

done_testing();
