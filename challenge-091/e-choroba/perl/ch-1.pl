#!/usr/bin/perl
use warnings;
use strict;

sub count_number {
    local ($_) = @_;
    s/((.)\2*)/length($1) . $2/ger
}

use Test::More tests => 2;
is count_number(1122234), 21321314, 'Example 1';
is count_number(2333445), 12332415, 'Example 2';
