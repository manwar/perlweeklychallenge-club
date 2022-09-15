#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

sub max_index (@list) {
    my $max_i = 0;
    for my $i (1 .. $#list) {
        $max_i = $i if $list[$i] > $list[$max_i];
    }
    return $max_i
}

use Test::More tests => 3;

is max_index(5, 2, 9, 1, 7, 6), 2, 'Example 1';
is max_index(4, 2, 3, 1, 5, 0), 4, 'Example 2';

is max_index(10, 10, 10), 0, 'Repeated';
