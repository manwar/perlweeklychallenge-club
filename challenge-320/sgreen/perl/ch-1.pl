#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'max';

sub main (@ints) {
    # Count the number of positive and negative integers
    my $pos_count = grep { $_ > 0 } @ints;
    my $neg_count = grep { $_ < 0 } @ints;

    # Return the maximum of these two values
    say max( $pos_count, $neg_count );
}

main(@ARGV);
