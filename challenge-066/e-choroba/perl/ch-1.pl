#! /usr/bin/perl
use warnings;
use strict;

sub div {
    my ($m, $n) = @_;
    my $s = 1;
    $s = -$s, $n = -$n if $n < 0;
    $s = -$s, $n = -$n if $m < 0;
    my $i = 0;
    while (abs $m > abs $n) {
        $m -= $n;
        $i += $s;
    }
    --$i if $i < 0;
    return $i
}

use Test::More tests => 4;
is div( 5,  2),  2;
is div(-5,  2), -3;
is div( 5, -2), -3;
is div(-5, -2),  2;
