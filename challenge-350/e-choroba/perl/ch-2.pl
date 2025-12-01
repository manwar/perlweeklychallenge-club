#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub shuffle_pairs($from, $to, $count) {
    my $found = 0;
    for my $n ($from .. $to) {
        my $c = 0;
        my $s = join "", sort split //, $n;
        for my $w (2 .. 9) {
            my $m = $n * $w;
            next if length($m) > length($n);
            next if $s ne join "", sort split //, $m;
            ++$c;
        }
        ++$found if $c >= $count;
    }
    return $found
}

use Test::More tests => 5;

is shuffle_pairs(1, 1000, 1), 0, 'Example 1';
is shuffle_pairs(1500, 2500, 1), 3, 'Example 2';
is shuffle_pairs(1_000_000, 1_500_000, 5), 2, 'Example 3';
is shuffle_pairs(13_427_000, 14_100_000, 2), 11, 'Example 4';
is shuffle_pairs(1030, 1130, 1), 2, 'Example 5';
