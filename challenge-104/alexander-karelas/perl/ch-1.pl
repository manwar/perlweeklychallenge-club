#!/usr/bin/env perl

use v5.30;
use warnings;

use experimental 'signatures';

sub fusc ($n) {
    return $n if $n <= 1;
    if ($n % 2 == 0) {
        return fusc($n / 2);
    } else {
        return fusc(($n - 1) / 2) + fusc(($n + 1) / 2);
    }
}

for (my $i = 0; $i < 50; $i++) {
    say $i, ": ", fusc($i);
}