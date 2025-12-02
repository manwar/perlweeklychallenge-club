#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

my @examples = (
    { in => "abcaefg", exp => 5 },
    { in => "xyzzabc", exp => 3 },
    { in => "aababc",  exp => 1 },
    { in => "qwerty",  exp => 4 },
    { in => "zzzaaa",  exp => 0 },
);

is(good_substring($_->{in}), $_->{exp}) for @examples;

done_testing;

sub good_substring {
    my ($str) = @_;

    return grep { !/(.).*\1/ }
           map  { substr($str, $_, 3) }
           0..length($str) - 3;
}
