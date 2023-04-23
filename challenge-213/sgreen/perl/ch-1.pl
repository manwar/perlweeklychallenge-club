#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@array) {
    # Sort the numbers, evens first
    @array = sort { $a % 2 <=> $b % 2 || $a <=> $b } @array;
    say join ', ', @array;
}

main(@ARGV);