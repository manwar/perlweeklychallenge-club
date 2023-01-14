#! /usr/bin/perl
use warnings;
use strict;
use experimental qw{ signatures };

use List::Util qw{ sum };

sub good_pairs ($list) {
    my %counts;
    ++$counts{$_} for @$list;
    return sum(map $_ * ($_ - 1) / 2, values %counts) // 0
}

use Test::More tests => 3 + 2;

is good_pairs([1, 2, 3, 1, 1, 3]), 4, 'Example 1';
is good_pairs([1, 2, 3]), 0, 'Example 2';
is good_pairs([1, 1, 1, 1]), 6, 'Example 3';

is good_pairs([1, 2, 1, 2, 1, 2, 1, 2, 1]), 16, '5+4';
is good_pairs([]), 0, 'Empty';
