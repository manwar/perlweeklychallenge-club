#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ sum0 };

my $MAX = 1 + ord 'z';
sub reverse_degree($str) {
    sum0(map $_ * ($MAX - ord substr $str, 0, 1, ""), 1 .. length $str)
}

use Test::More tests => 5 + 1;

is reverse_degree('z'), 1, 'Example 1';
is reverse_degree('a'), 26, 'Example 2';
is reverse_degree('bbc'), 147, 'Example 3';
is reverse_degree('racecar'), 560, 'Example 4';
is reverse_degree('zyx'), 14, 'Example 5';

is reverse_degree(""), 0, 'Empty';
