#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub senior_citizens(@list) {
    scalar grep +(/(..)..$/)[0] >= 60, @list
}

use Test::More tests => 2;

is senior_citizens('7868190130M7522', '5303914400F9211', '9273338290F4010'), 2,
    'Example 1';
is senior_citizens('1313579440F2036', '2921522980M5644'), 0,
    'Example 2';
