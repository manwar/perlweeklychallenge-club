#!/usr/bin/perl

use v5.40;

use Test::More tests => 3;

use List::Util qw(uniq);

sub get_third_maximum {
    my @l = uniq sort { $b <=> $a } @_;
    return @l > 2 ? $l[2] : $l[0];
}

is(get_third_maximum(5, 6, 4, 1), 4);
is(get_third_maximum(4, 5),       5);
is(get_third_maximum(1, 2, 2, 3), 1);
