#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub count_common($str1, $str2) {
    my %common;
    @common{ @$str1 } = (1) x @$str1;
    $common{$_} |= 2 for @$str2;
    return scalar grep $_ == 3, values %common
}

use Test::More tests => 3;

is count_common(['perl', 'weekly', 'challenge'],
                ['raku', 'weekly', 'challenge']),
    2, 'Example 1';

is count_common(['perl', 'raku', 'python'], ['python', 'java']),
    1, 'Example 2';

is count_common(['guest', 'contribution'], ['fun', 'weekly', 'challenge']),
    0, 'Example 3';
