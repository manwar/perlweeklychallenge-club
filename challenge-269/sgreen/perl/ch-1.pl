#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    # Count the number of even number integers
    my $even_count = grep { $_ % 2 == 0 } @ints;

    # True if there are two or more of them
    say $even_count >= 2 ? 'true' : 'false';
}

main(@ARGV);