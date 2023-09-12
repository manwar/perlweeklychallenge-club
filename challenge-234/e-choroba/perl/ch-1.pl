#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ min };

sub common_characters(@words) {
    my %seen;
    for my $index (0 .. $#words) {
        ++$seen{$_}[$index] for split //, $words[$index];
    }
    return [map +(($_) x min(map $_ // 0, @{ $seen{$_} }[0 .. $#words])),
            keys %seen]
}

use Test2::V0;
plan 3 + 1;

is common_characters('java', 'javascript', 'julia'),
    bag { item $_ for qw( j a ) }, 'Example 1';
is common_characters('bella', 'label', 'roller'),
    bag { item $_ for qw( e l l ) }, 'Example 2';
is common_characters('cool', 'lock', 'cook'),
    bag { item $_ for qw( c o ) }, 'Example 3';

is common_characters('abc', 'xyz', 'abc'), [], 'No common chars';
