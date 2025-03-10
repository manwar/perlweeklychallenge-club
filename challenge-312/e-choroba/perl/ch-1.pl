#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub minimum_time($str) {
    my $previous = 'a';
    my $time = 0;
    for my $char (split //, $str) {
        my $distance = abs(ord($char) - ord($previous));
        $distance = 26 - $distance if $distance > 13;
        $time += 1 + $distance;
        $previous = $char
    }
    return $time
}

use Test::More tests => 3;

is minimum_time('abc'), 5, 'Example 1';
is minimum_time('bza'), 7, 'Example 2';
is minimum_time('zjpc'), 34, 'Example 3';
