#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ sum };

sub digital_root($int) {
    my $persistence = 0;
    while (1 < length $int) {
        $int = sum(split //, $int);
        ++$persistence
    }
    return {Persistence => $persistence, Digital_Root => $int}
}

use Test2::V0;
plan 5;

is digital_root(38), {Persistence => 2, Digital_Root => 2}, 'Example 1';
is digital_root(7), {Persistence => 0, Digital_Root => 7}, 'Example 2';
is digital_root(999), {Persistence => 2, Digital_Root => 9}, 'Example 3';
is digital_root(1999999999), {Persistence => 3, Digital_Root => 1}, 'Example 4';
is digital_root(101010), {Persistence => 1, Digital_Root => 3}, 'Example 5';
