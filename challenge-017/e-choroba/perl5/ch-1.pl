#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use Memoize;
memoize('ackermann');

sub ackermann {
    my ($m, $n) = @_;

    return $n + 1 if 0 == $m;

    no warnings 'recursion';
    return ackermann($m - 1, 1) if 0 == $n;

    return ackermann($m - 1, ackermann($m, $n - 1))
}

say ackermann(@ARGV);

