#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub pile ( $remain, $minimum ) {
    my $found = 0;
    foreach my $take ( $minimum .. $remain ) {
        if ( $remain == $take ) {
            # We have a solution
            $found++;
        }
      else: {
            # Take this amount from the remaining pennies
            $found += pile( $remain - $take, $take );
        }
    }
    return $found;
}

sub main ($n) {
    say pile( $n, 1 );
}

main( $ARGV[0] );