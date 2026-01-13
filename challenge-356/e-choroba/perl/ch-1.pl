#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub kolakoski_sequence($int) {
    my @s;
    my $i = 1;
    while (@s < $int) {
        push @s, (($i % 2) ? 1 : 2) x ($s[ $i - 1 ] // $i);
        ++$i;
    }
    return join("", @s[0 .. $int - 1]) =~ tr/1//
}

use Test::More tests => 5 + 1;

is kolakoski_sequence(4), 2, 'Example 1';
is kolakoski_sequence(5), 3, 'Example 2';
is kolakoski_sequence(6), 3, 'Example 3';
is kolakoski_sequence(7), 4, 'Example 4';
is kolakoski_sequence(8), 4, 'Example 5';
is kolakoski_sequence(29), 15, 'Longer example';
