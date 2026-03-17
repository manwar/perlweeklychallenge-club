#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ sum0 };

sub alphabet_index_digit_sum($str, $k) {
    $str =~ s/(.)/ord($1) + 1- ord 'a'/ge;
    for (0 .. $k) {
        $str = sum0(split //, $str);
    }
    return $str
}

use Test::More tests => 5 + 1;

is alphabet_index_digit_sum('abc', 1), 6, 'Example 1';
is alphabet_index_digit_sum('az', 2), 9, 'Example 2';
is alphabet_index_digit_sum('cat', 1), 6, 'Example 3';
is alphabet_index_digit_sum('dog', 2), 8, 'Example 4';
is alphabet_index_digit_sum('perl', 3), 6, 'Example 5';

is alphabet_index_digit_sum("", 3), 0, 'Zero';
