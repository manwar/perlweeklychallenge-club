#! /usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ sum0 };

sub unique_sum(@int) {
    my %seen;
    ++$seen{$_} for @int;
    return sum0(grep 1 == $seen{$_}, keys %seen)
}

use Test::More tests => 3;

is unique_sum(2, 1, 3, 2), 4, 'Example 1';
is unique_sum(1, 1, 1, 1), 0, 'Example 2';
is unique_sum(2, 1, 3, 4), 10, 'Example 3';
