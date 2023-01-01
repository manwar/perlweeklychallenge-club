#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main(@list) {
    my @solution = (
        # The solution is all the non-zero values ...
        (grep { $_ != 0 } @list),
        # ... followed by the zero values
        (grep { $_ == 0 } @list),
    );

    say join ', ', @solution;
}

main(@ARGV);