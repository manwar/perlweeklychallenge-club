#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my @examples = (
    {
        in  => [["a", "bc"], ["ab", "c"]],
        out => "true"
    },
    {
        in  => [["a", "b", "c"], ["a", "bc"]],
        out => "true"
    },
    {
        in  => [["a", "bc"], ["a", "c", "b"]],
        out => "false"
    },
    {
        in  => [["ab", "c", ""], ["", "a", "bc"]],
        out => "true"
    },
    {
        in  => [["p", "e", "r", "l"], ["perl"]],
        out => "true"
    },
);

is equal_list(@{$_->{in}}), $_->{out} foreach @examples;

done_testing;

sub equal_list {
    my ($arr1, $arr2) = @_;

    return join("", @$arr1) eq join("", @$arr2) ? "true" : "false";
}
