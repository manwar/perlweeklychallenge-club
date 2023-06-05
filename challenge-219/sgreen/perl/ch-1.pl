#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@array) {
    @array = sort { $a <=> $b } map { $_**2 } @array;
    say join ', ', @array;
}

main(@ARGV);
