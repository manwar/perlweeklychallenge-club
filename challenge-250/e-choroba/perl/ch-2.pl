#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ max };

sub alphanumeric_string_value(@alphanumstr) {
    return max(map /^[0-9]+$/ ? 0 + $_ : length, @alphanumstr)
}

use Test::More tests => 2;

is alphanumeric_string_value('perl', '2', '000', 'python', 'r4ku'), 6,
    'Example 1';
is alphanumeric_string_value('001', '1', '000', '0001'), 1,
    'Example 2';
