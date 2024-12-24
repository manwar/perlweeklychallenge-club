#!/usr/bin/perl

use v5.40;

use Test::More tests => 2;

use List::Util qw(max);

sub form_largest {
    join q{}, sort { extend($b, $a) cmp extend($a, $b) } @_;
}

sub extend {
    $_[0] . (substr($_[0], -1) x (max(length($_[1]) - length($_[0]), 0)));
}

is(form_largest(20, 3),           320);
is(form_largest(3, 30, 34, 5, 9), 9534330);
