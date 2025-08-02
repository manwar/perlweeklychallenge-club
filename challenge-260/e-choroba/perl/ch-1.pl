#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub unique_occurrences(@ints) {
    my %count;
    ++$count{$_} for @ints;
    my %occ;
    for (values %count) {
        return 0 if $occ{$_}++;
    }
    return 1
}

use Test::More tests => 3 + 1;

is unique_occurrences(1, 2, 2, 1, 1, 3), 1, 'Example 1';
is unique_occurrences(1, 2, 3), 0, 'Example 2';
is unique_occurrences(-2, 0, 1, -2, 1, 1, 0, 1, -2, 9), 1, 'Example 3';

is unique_occurrences(), 1, 'Empty';
