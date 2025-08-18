#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ min };

sub common_characters(@words) {
    my %seen;
    for my $i (0 .. $#words) {
        ++$seen{$_}[$i] for split //, $words[$i];
    }
    return [map +($_) x min(map $_ // 0, @{ $seen{$_} }[0 .. $#words]),
            keys %seen]
}

use Test2::V0;
plan(5);

is common_characters('bella', 'label', 'roller'),
    bag { item $_ for qw( e l l ); end() }, 'Example 1';
is common_characters('cool', 'lock', 'cook'),
    bag { item $_ for qw( c o ); end() }, 'Example 2';
is common_characters('hello', 'world', 'pole'),
    bag { item $_ for qw( l o ); end() }, 'Example 3';
is common_characters('abc', 'def', 'ghi'), [], 'Example 4';
is common_characters('aab', 'aac', 'aaa'),
    bag { item $_ for qw( a a ); end() }, 'Example 5';
