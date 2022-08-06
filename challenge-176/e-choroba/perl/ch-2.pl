#! /usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub reversible_numbers ($below) {
    return [ grep is_reversible_number($_), 1 .. $below - 1 ]
}

sub is_reversible_number ($n) { ($n + reverse $n) !~ /[02468]/ }

use Test2::V0;
plan 1;

is reversible_numbers(100),
    [10, 12, 14, 16, 18, 21, 23, 25, 27,
     30, 32, 34, 36, 41, 43, 45,
     50, 52, 54, 61, 63, 70, 72, 81, 90],
    'Below 100';
