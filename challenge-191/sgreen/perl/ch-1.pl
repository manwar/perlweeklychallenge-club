#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@nums) {
    # Sort the list numerically
    @nums = sort { $a <=> $b } @nums;

    say $nums[-1] >+ 2 * $nums[-2] ? 1 : -1;
}

main(@ARGV);
