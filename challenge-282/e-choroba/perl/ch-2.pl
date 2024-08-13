#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub changing_keys($str) {
    return length($str =~ tr/A-Za-z/a-za-z/sr) - 1
}

use Test::More tests => 3;

is changing_keys('pPeERrLl'), 3, 'Example 1';
is changing_keys('rRr'), 0, 'Example 2';
is changing_keys('GoO'), 1, 'Example 3';
