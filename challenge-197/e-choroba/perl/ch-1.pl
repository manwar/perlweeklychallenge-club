#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use List::MoreUtils qw{ part };

sub move_zero(@list) {
    return [map @$_, grep defined, part { ! $_ } @list]
}

use Test2::V0;
plan(3 + 1);

is move_zero(1, 0, 3, 0, 0, 5), [1, 3, 5, 0, 0, 0], 'Example 1';
is move_zero(1, 6, 4), [1, 6, 4], 'Example 2';
is move_zero(0, 1, 0, 2, 0), [1, 2, 0, 0, 0], 'Example 3';

is move_zero(0, 0, 0), [0, 0, 0], 'Nothing but zeros';
