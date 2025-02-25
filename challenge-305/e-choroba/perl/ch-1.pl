#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use Math::Prime::Util qw{ is_prime };

sub binary_prefix(@binary) {
    my @r;
    my $bin = "";
    for my $digit (@binary) {
        $bin .= $digit;
        push @r, is_prime(oct("0b$bin"));
    }
    return \@r
}

use Test2::V0;
plan(3);
use constant {true => bool(1),
              false => bool(0)};

is binary_prefix(1, 0, 1), [false, true, true], 'Example 1';
is binary_prefix(1, 1, 0), [false, true, false], 'Example 2';
is binary_prefix(1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1),
    [false, true, true, false, false, true, false, false, false, false, false,
     false, false, false, false, false, false, false, false, true],
    'Example 3';
