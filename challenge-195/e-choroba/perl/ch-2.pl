#! /usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

sub most_frequent_even ($list) {
    my @even = grep 0 == $_ % 2, @$list;
    my %freq;
    ++$freq{$_} for @even;
    return (
        sort { $freq{$b} <=> $freq{$a} }
        sort { $a <=> $b }
        keys %freq
    )[0] // -1
}

use Test::More tests => 3;

is most_frequent_even([1,1,2,6,2]), 2, 'Example 1';
is most_frequent_even([1,3,5,7]), -1, 'Example 2';
is most_frequent_even([6,4,4,6,1]), 4, 'Example 3';
