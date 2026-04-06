#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use List::Util qw(max);

my @examples = (
    { s => "15456",  c => "5", o => "1546"  },
    { s => "7332",   c => "3", o => "732"   },
    { s => "2231",   c => "2", o => "231"   },
    { s => "543251", c => "5", o => "54321" },
    { s => "1921",   c => "1", o => "921"   },
);

is make_it_bigger($_->{s}, $_->{c}), $_->{o} foreach @examples;

done_testing;

sub make_it_bigger {
    my ($s, $c) = @_;
    return max map {
        substr($s, $_, 1) eq $c
        ? (substr($s, 0, $_) . substr($s, $_ + 1))
        : () } 0..length($s)-1;
}
