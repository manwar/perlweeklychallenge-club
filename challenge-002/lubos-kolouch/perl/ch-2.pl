#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests => 4;

my @chars = ('0' .. '9', 'A' .. 'Y');

# Convert from base35 to integer
sub base35_to_int {
    my $str = shift;
    my $int = 0;
    my $len = length($str);
    for (my $i = 0; $i < $len; $i++) {
        my $char = substr($str, $i, 1);
        my $val = 0;
        for (my $j = 0; $j < @chars; $j++) {
            if ($chars[$j] eq $char) {
                $val = $j;
                last;
            }
        }
        $int += $val * (35 ** ($len - $i - 1));
    }
    return $int;
}

# Convert from integer to base35
sub int_to_base35 {
    my $int = shift;
    my $str = '';
    while ($int > 0) {
        my $mod = $int % 35;
        $str = $chars[$mod] . $str;
        $int = int($int / 35);
    }
    return $str;
}

# Test cases
is(base35_to_int('A'), 10);
is(base35_to_int('1A'), 45);
is(int_to_base35(45), '1A');
is(int_to_base35(12345), 'A2P');
