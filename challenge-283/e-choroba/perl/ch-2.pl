#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub digit_count_value(@ints) {
    my %seen;
    ++$seen{$_} for @ints;
    for my $i (0 .. $#ints) {
        return unless $ints[$i] == ($seen{$i} // 0);
    }
    return 1
}

use Test::More tests => 2 + 1;

ok digit_count_value(1, 2, 1, 0), 'Example 1';
ok ! digit_count_value(0, 3, 0), 'Example 2';
ok digit_count_value(10, 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0), '>9';
