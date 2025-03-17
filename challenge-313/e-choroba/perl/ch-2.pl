#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

# See also 254/2.

sub reverse_letters($str) {
    my @alpha = $str =~ /([[:alpha:]])/g;
    $str =~ s/[[:alpha:]]/ pop @alpha /ge;
    return $str
}

use Test::More tests => 3;

is reverse_letters('p-er?l'), 'l-re?p', 'Example 1';
is reverse_letters('wee-k!L-y'), 'yLk-e!e-w', 'Example 2';
is reverse_letters('_c-!h_all-en!g_e'), '_e-!g_nel-la!h_c', 'Example 3';
