#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub maximum_average($ints, $n) {
    my $sum = 0;
    $sum += $ints->[$_] for 0 .. $n - 1;
    my $max_sum = $sum;
    for my $i ($n .. $#$ints) {
        $sum += $ints->[$i] - $ints->[ $i - $n ];
        $max_sum = $sum if $sum > $max_sum;
    }
    return $max_sum / $n
}

use Test::More tests => 2;

is maximum_average([1, 12, -5, -6, 50, 3], 4), 12.75, 'Example 1';
is maximum_average([5], 1), 5, 'Example 2';
