#!/usr/bin/env perl

use v5.10;
use strict;
use warnings;

sub uniq {
    my %seen;
    return grep { ! $seen{$_}++ } @_;
}

sub third_highest {
    my @a = uniq reverse sort @_;
    return @a >= 3 ? $a[2] : $a[0];
}

use Test::More;

my @tests = (
    [ [], undef ],
    [ [ 6 ], 6 ],
    [ [ 5, 3, 4 ], 3 ],
    [ [ 5, 6 ], 6 ],
    [ [ 5, 4, 4, 3 ], 3 ],
);

for ( @tests ) {
    is third_highest( @{$_->[0]} ), $_->[1],
        "third_highest( @{$_->[0]} ) == " . ( $_->[1] // "undef" );
}

done_testing;
