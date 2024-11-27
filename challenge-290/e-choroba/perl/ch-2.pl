#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub luhns_algorithm($str) {
    $str =~ tr/0-9//dc;
    my $payload = chop $str;
    my $sum  = 0;
    my $even = 0;
    for my $digit (reverse split //, $str) {
        $sum += $even           ? $digit
              : 2 * $digit > 9  ? 2 * $digit - 9
              :                   2 * $digit;
        $even = ! $even;
    }
    return 0 == ($sum + $payload) % 10 ? 1 : 0
}

use Test::More tests => 3;

is luhns_algorithm('17893729974'), 1, 'Example 1';
is luhns_algorithm('4137 8947 1175 5904'), 1, 'Example 2';
is luhns_algorithm('4137 8974 1175 5904'), 0, 'Example 3';
