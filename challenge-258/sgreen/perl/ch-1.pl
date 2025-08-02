#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'sum';

sub main (@ints) {
    my $count = grep { length($_) % 2 == 0 } @ints;
    say $count;
}

main(@ARGV);