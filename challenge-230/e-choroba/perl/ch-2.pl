#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub count_words($prefix, @words) {
    scalar grep /^\Q$prefix/, @words
}

use Test::More tests => 2 + 1;

is count_words('at', 'pay', 'attention', 'practice', 'attend'),
    2, 'Example 1';
is count_words('ja', 'janet', 'julia', 'java', 'javascript'),
    3, 'Example 2';
is count_words('xyz', 'abc', 'def'), 0, 'zero';
