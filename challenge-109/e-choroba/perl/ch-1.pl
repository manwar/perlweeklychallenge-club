#!/usr/bin/perl
use warnings;
use strict;

sub chowla {
    my ($n) = @_;
    my $ch = 0;
    my $s = sqrt $n;
    0 == $n % $_ and $ch += $_ + $n / $_ for 2 .. $s;
    $ch -= $s if $n > 1 && $s == int $s;
    return $ch
}

sub chowla_list {
    my ($size) = @_;
    return map chowla($_), 1 .. $size
}

use Test::More tests => 2;

is_deeply [chowla_list(20)],
    [0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21],
    'Output';

is chowla(2147483647), 0, 'Effectively compute C(2^31 - 1)';
