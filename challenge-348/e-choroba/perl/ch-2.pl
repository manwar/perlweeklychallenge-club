#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

{   my @numbers = (60, 15, 5, 1);
    sub covert_time($source, $target) {
        my @times = map { /^(..):(..)$/; $1 * 60 + $2 } $source, $target;
        $times[1] += 24 * 60 if $times[1] < $times[0];
        my $diff = $times[1] - $times[0];
        my $steps = 0;
        for my $n (@numbers) {
            $steps += int($diff / $n);
            $diff  %= $n;
        }
        return $steps
    }
}

use Test::More tests => 5;

is covert_time('02:30', '02:45'), 1, 'Example 1';
is covert_time('11:55', '12:15'), 2, 'Example 2';
is covert_time('09:00', '13:00'), 4, 'Example 3';
is covert_time('23:45', '00:30'), 3, 'Example 4';
is covert_time('14:20', '15:25'), 2, 'Example 5';
