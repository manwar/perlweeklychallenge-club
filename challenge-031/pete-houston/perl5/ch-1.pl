#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;
use Try::Tiny;

is  cant_divide (3, 5),      undef, '3 / 5 is fine';
is  cant_divide (3.9, -5.2), undef, '3.9 / -5.2 is fine';
isnt cant_divide (6, 0),      undef, '6 / 0 is impossible';

sub cant_divide {
    my ($numer, $denom) = @_;
    my $cant;
    try {
        $numer / $denom;
    } catch {
        $cant = $_;
    };
    return $cant;
}
