#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
    qw{ experimental::postderef experimental::smartmatch experimental::signatures };

my %done;

for my $m ( 1 .. 10 ) {
    for my $n ( 1 .. 10 ) {
        my $o = 12 - ( $m + $n );
        next unless $o > 0;
        my $p = $m + $n + $o;
        my $i = join ' ', sort $m, $n, $o;
        next if $done{$i}++;
        say qq{    $m + $n + $o = $p};
    }
}

__DATA__

    1 + 1 + 10 = 12
    1 + 2 + 9 = 12
    1 + 3 + 8 = 12
    1 + 4 + 7 = 12
    1 + 5 + 6 = 12
    2 + 2 + 8 = 12
    2 + 3 + 7 = 12
    2 + 4 + 6 = 12
    2 + 5 + 5 = 12
    3 + 3 + 6 = 12
    3 + 4 + 5 = 12
    4 + 4 + 4 = 12
