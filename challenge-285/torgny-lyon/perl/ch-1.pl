#!/usr/bin/perl

use v5.40;

use Test::More tests => 2;

sub get_no_connection {
    my ($c) = my %r = map { $_->[0], $_->[1] } @_;
    $c = $r{$c} while $r{$c};
    return $c;
}

is(get_no_connection([ 'B', 'C' ], [ 'D', 'B' ], [ 'C', 'A' ]), 'A');
is(get_no_connection([ 'A', 'Z' ]), 'Z');
