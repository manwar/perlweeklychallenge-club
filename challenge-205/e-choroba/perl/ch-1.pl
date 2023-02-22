#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';
use List::Util qw{ uniq };

sub third_highest($list) {
    my @sorted_uniq = sort { $a <=> $b } uniq(@$list);
    return @sorted_uniq[@sorted_uniq > 2 ? -3 : -1];
}

use Test::More tests => 3 + 2;

is third_highest([5, 3, 4]), 3, 'Example 1';
is third_highest([5, 6]), 6, 'Example 2';
is third_highest([5, 4, 4, 3]), 3, 'Example 3';

is third_highest([2]), 2, 'Single element';
is third_highest([(1 .. 400) x 10]), 398, 'Long list';
