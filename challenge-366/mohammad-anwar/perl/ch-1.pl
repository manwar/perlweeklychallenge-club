#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my @examples = (
    {
        str   => "apple",
        array => [ "a", "ap", "app", "apple", "banana" ],
        out   => 4
    },
    {
        str   => "bird",
        array => [ "cat", "dog", "fish" ],
        out   => 0
    },
    {
        str   => "hello",
        array => [ "hello", "he", "hell", "heaven", "he" ],
        out   => 4
    },
    {
        str   => "coding",
        array => [ "", "code", "coding", "cod" ],
        out   => 3
    },
    {
        str   => "program",
        array => [ "p", "pr", "pro", "prog", "progr", "progra", "program" ],
        out   => 7
    },
);

is count_prefixes($_->{str}, @{$_->{array}}), $_->{out} foreach @examples;

done_testing;

sub count_prefixes {
    my ($str, @array) = @_;
    my $count = grep { $str =~ /^$_/ } @array;
    return $count;
}
