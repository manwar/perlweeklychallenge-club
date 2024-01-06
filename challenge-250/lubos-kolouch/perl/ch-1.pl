#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 3;

sub smallest_index {
    my @ints = @_;
    foreach my $i (0 .. $#ints) {
        return $i if $i % 10 == $ints[$i];
    }
    return -1;
}

is(smallest_index(0, 1, 2), 0, 'Example 1');
is(smallest_index(4, 3, 2, 1), 2, 'Example 2');
is(smallest_index(1, 2, 3, 4, 5, 6, 7, 8, 9, 0), -1, 'Example 3');
