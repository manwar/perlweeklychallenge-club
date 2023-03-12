#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util qw(pairkeys sum);

sub main (@n) {
    my $h_index = 0;

    foreach my $i ( 1 .. $#n + 1 ) {
        # Count the number of items that are >= i
        my $count = sum( map { $_ >= $i } @n );
        if ( $count >= $i ) {
            $h_index = $i;
        }
        else {
            # No point trying any more, as it will be False.
            last;
        }
    }

    say $h_index;
}

main(@ARGV);