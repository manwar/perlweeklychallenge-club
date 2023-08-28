#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main(@ints) {
    my @solution = ( map { split // } @ints );
    say '(', join(', ', @solution), ')';
}

main(@ARGV);