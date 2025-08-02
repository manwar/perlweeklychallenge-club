#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub count_asterisks($str) {
    $str =~ s/\|[^|]*\|//g;
    return $str =~ tr/*//
}

use Test::More tests => 3 + 1;

is count_asterisks('p|*e*rl|w**e|*ekly|'), 2, 'Example 1';
is count_asterisks('perl'), 0, 'Example 2';
is count_asterisks('th|ewe|e**|k|l***ych|alleng|e'), 5, 'Example 3';

is count_asterisks('p*rl|*'), 2, 'Final bar missing';
