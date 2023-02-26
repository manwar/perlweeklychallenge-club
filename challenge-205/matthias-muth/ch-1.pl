#!/usr/bin/env perl

use strict;
use warnings;

use List::Util 1.45 qw( uniq );

sub third_highest {
    my @a = uniq reverse sort @_;
    return @a >= 3 ? $a[2] : $a[0];
}

use Test::More;

my @tests = (
    [ [],             undef ],
    [ [ 6 ],          6 ],
    [ [ 5, 3, 4 ],    3 ],
    [ [ 5, 6 ],       6 ],
    [ [ 5, 4, 4, 3 ], 3 ],
);

is third_highest( @{$_->[0]} ), $_->[1],
    "third_highest( @{$_->[0]} ) == " . ( $_->[1] // "undef" )
    for @tests;

done_testing;
