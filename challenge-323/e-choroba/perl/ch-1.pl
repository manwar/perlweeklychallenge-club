#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub increment_decrement(@operations) {
    return @operations - 2 * grep /--/, @operations
}

use Test::More tests => 3 + 1;

is increment_decrement('--x', 'x++', 'x++'), 1, 'Example 1';
is increment_decrement('x++', '++x', 'x++'), 3, 'Example 2';
is increment_decrement('x++', '++x', '--x', 'x--'), 0, 'Example 3';

is increment_decrement(), 0, 'Empty';
