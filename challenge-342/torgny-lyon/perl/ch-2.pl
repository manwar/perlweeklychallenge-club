#!/usr/bin/perl

use v5.36;

use Test::More tests => 5;

use List::Util qw(max);

sub get_max_score {
    max map {
        (() = substr($_[0], 0, $_) =~ /0/g) + (() = substr($_[0], $_) =~ /1/g)
    } 1..(length($_[0]) - 1);
}

is(get_max_score("0011"),   4);
is(get_max_score("0000"),   3);
is(get_max_score("1111"),   3);
is(get_max_score("0101"),   3);
is(get_max_score("011101"), 5);
