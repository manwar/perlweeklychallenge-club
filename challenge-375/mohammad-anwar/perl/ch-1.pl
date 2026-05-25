#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use List::Util qw(any);

my @examples = (
    {
        in  => [ ["apple", "banana", "cherry"],
                 ["banana", "cherry", "date"],
               ],
        out => 2
    },
    {
        in  => [ ["a", "ab", "abc"],
                 ["a", "a", "ab", "abc"],
               ],
        out => 2
    },
    {
        in  => [ ["orange", "lemon"],
                 ["grape", "melon"],
               ],
        out => 0
    },
    {
        in  => [ ["test", "test", "demo"],
                 ["test", "demo", "demo"],
               ],
        out => 0
    },
    {
        in  => [ ["Hello", "world"],
                 ["hello", "world"],
               ],
        out => 1
    },
);

is count_unique_common(@{$_->{in}}), $_->{out} foreach @examples;

done_testing;

sub count_unique_common {
    my ($array1, $array2) = @_;

    my %freq1;
    my %freq2;
    $freq1{$_}++ for @$array1;
    $freq2{$_}++ for @$array2;

    return scalar grep {
        $freq1{$_} == 1 && exists $freq2{$_} && $freq2{$_} == 1
    } keys %freq1;
}
