#!/usr/bin/perl
use warnings;
use strict;
use utf8;
use experimental 'signatures';

use POSIX qw{ round };
use List::Util qw{ min max };

my @BLOCKS = split //, '▁▂▃▄▅▆▇█';
sub unicode_sparkline (@n) {
    my ($min, $max) = (min(@n), max(@n));
    my $step = ($max - $min) / 7;
    return join "", @BLOCKS[map round(($_ - $min) / $step), @n]
}

use Test::More tests => 1;

is unicode_sparkline(map $_ * 2.3, 1 .. 8), '▁▂▃▄▅▆▇█';
