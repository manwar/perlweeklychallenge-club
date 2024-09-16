#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub unique_number(@ints) {
    my %seen;
    ++$seen{$_} for @ints;
    return (grep 1 == $seen{$_}, keys %seen)[0]
}

use Test::More tests => 4;

is unique_number(3, 3, 1), 1, 'Example 1';
is unique_number(3, 2, 4, 2, 4), 3, 'Example 2';
is unique_number(1), 1, 'Example 3';
is unique_number(4, 3, 1, 1, 1, 4), 3, 'Example 4';
