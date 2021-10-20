#!/usr/bin/perl
use warnings;
use strict;

sub middle_3digits {
    my ($n) = @_;
    my $l = length ($n = abs $n);
    die "even number of digits\n" if 0 == $l % 2;
    die "too short\n" if $l < 3;

    my $remove = ($l - 3) / 2;
    substr $n, -$remove, $remove, "";
    substr $n, 0, $remove, "";
    return $n
}

use Test2::V0;
plan 4;

is middle_3digits(1234567),
    345, 'Example 1';

is middle_3digits(-123),
    123, 'Example 2';

like dies { middle_3digits(1) },
    qr/too short$/, 'Example 3';

like dies { middle_3digits(10) },
    qr/even number of digits$/, 'Example 4';
