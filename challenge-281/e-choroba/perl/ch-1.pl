#!/usr/bin/perl
use warnings;
use strict;
use builtin qw( true false );
use experimental qw( signatures );

sub check_color($coordinates) {
    my ($column, $row) = split //, $coordinates;
    return 1 == ($row + ord $column) % 2
}

use Test::More tests => 3;

is check_color('d3'), true,  'Example 1';
is check_color('g5'), false, 'Example 2';
is check_color('e6'), true,  'Example 3';
