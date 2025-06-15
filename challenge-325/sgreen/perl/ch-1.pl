#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    my $max_count     = 0;
    my $current_count = 0;
    foreach my $num (@ints) {
        if ( $num == 1 ) {
            $current_count++;
            if ( $current_count > $max_count ) {
                $max_count = $current_count;
            }
        }
        else {
            $current_count = 0;
        }
    }

    say $max_count;
}

main(@ARGV);
