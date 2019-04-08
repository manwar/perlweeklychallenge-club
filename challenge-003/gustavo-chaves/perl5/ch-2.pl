#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

my @row = (1);

for (1 .. $ARGV[0]) {
    say join(' ', @row);
    @row = (1, (map {$row[$_-1] + $row[$_]} 1 .. @row-1), 1);
}

