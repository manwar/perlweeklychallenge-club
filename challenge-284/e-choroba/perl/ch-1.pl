#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub lucky_integer(@ints) {
    my %freq;
    ++$freq{$_} for @ints;
    return (sort { $b <=> $a } -1, grep $_ == $freq{$_}, keys %freq)[0]
}

use Test::More tests => 3 + 1;

is lucky_integer(2, 2, 3, 4), 2, 'Example 1';
is lucky_integer(1, 2, 2, 3, 3, 3), 3, 'Example 2';
is lucky_integer(1, 1, 1, 3), -1, 'Example 3';

is lucky_integer(-2, 0), -1, 'Zero & negative';
