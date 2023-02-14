#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

sub monotonic_array($arr) {
    my $first_cmp;
    for my $i (1 .. $#$arr) {
        my $cmp = $arr->[ $i - 1 ] <=> $arr->[$i];
        return 0 if $first_cmp && $cmp && $first_cmp != $cmp;
        $first_cmp //= $cmp;
    }
    return 1
}

use Test::More tests => 3 + 5;

is monotonic_array([1, 2, 2, 3]), 1, 'Example 1';
is monotonic_array([1, 3, 2]), 0, 'Example 2';
is monotonic_array([6, 5, 5, 4]), 1, 'Example 3';

is monotonic_array([5, 5, 4, 3]), 1, 'Starts flat';
is monotonic_array([2, 2, 2]), 1, 'All flat';
is monotonic_array([1, 2]), 1, 'Two elements';
is monotonic_array([1]), 1, 'Single element';
is monotonic_array([]), 1, 'Empty';
