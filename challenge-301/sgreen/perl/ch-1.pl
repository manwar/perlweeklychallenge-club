#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'max';

sub number_sort() {
    return "$a$b" <=> "$b$a";
}

sub main (@ints) {
    my @sorted_ints = sort { number_sort } @ints;
    say join '', reverse(@sorted_ints);
}

main(@ARGV);