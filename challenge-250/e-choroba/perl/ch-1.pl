#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ first };

sub smallest_index(@ints) {
    my $i = first { $_ % 10 == $ints[$_] } 0 .. $#ints;
    return $i // -1
}

use Test::More tests => 3;

is smallest_index(0, 1, 2), 0, 'Example 1';
is smallest_index(4, 3, 2, 1), 2, 'Example 2';
is smallest_index(1, 2, 3, 4, 5, 6, 7, 8, 9, 0), -1, 'Example 3';
