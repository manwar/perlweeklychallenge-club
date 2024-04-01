#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'max';

sub main (@ints) {
    my $neg_count = my $pos_count = 0;
    foreach my $i (@ints) {
        if ( $i < 0 ) {
            ++$neg_count;
        }
        elsif ( $i > 0 ) {
            ++$pos_count;
        }
    }

    say max( $neg_count, $pos_count );
}

main(@ARGV);