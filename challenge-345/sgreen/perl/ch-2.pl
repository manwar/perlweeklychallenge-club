#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    my @seen      = ();
    my @ans       = ();
    my $neg_count = 0;

    foreach my $i (@ints) {
        if ( $i > 0 ) {
            unshift @seen, $i;
            $neg_count = 0;
        }
        elsif ( $i == -1 ) {
            if ( $neg_count < @seen ) {
                push @ans, $seen[$neg_count];
            }
            else {
                push @ans, -1;
            }
            $neg_count++;
        }
        else {
            die "Input integers must be positive or -1.\n";
        }
    }

    say "(", join( ", ", @ans ), ")";
}

main(@ARGV);
