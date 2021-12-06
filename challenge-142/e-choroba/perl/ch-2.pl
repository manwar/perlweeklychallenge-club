#!/usr/bin/perl
use warnings;
use strict;

use threads;
use threads::shared;

use Test2::V0;
plan 1;

sub sleep_sort {
    my @sorted :shared;
    my @threads;
    for my $n (@_) {
        push @threads,
             'threads'->create(sub { sleep $n; push @sorted, $n });
    }
    $_->join for @threads;
    return @sorted
}

my @numbers = map 1 + int rand 20, 1 .. 50;
is [sleep_sort(@numbers)], [sort { $a <=> $b } @numbers], 'same';
