#!/usr/bin/perl
use warnings;
use strict;

sub leader_element {
    my ($list) = @_;
    return [] unless @$list;

    my @leaders = $list->[-1];
    for my $n (reverse @$list) {
        unshift @leaders, $n if $n > $leaders[0];
    }

    return \@leaders
}

use Test::More tests => 2;

is_deeply leader_element([9, 10, 7, 5, 6, 1]),
    [10, 7, 6, 1],
    'example 1';

is_deeply leader_element([3, 4, 5]),
    [5],
    'example 2';
