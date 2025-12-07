#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub is_shuffle_pair ( $n1, $n2 ) {
    return
      join( '', sort split( //, $n1 ) ) eq join( '', sort split( //, $n2 ) );
}

sub main ( $from, $to, $count ) {
    my $shuffle_pairs = 0;

    foreach my $value ( $from .. $to ) {
        my $this_count = 0;
        my $multiplier = 2;
        while (1) {
            my $candidate = $value * $multiplier;
            if ( $candidate >= 10**length($value) ) {
                last;
            }
            if ( is_shuffle_pair( $value, $candidate ) ) {
                $this_count++;
            }
            $multiplier++;
        }
        if ( $this_count >= $count ) {
            $shuffle_pairs++;
        }
    }

    say $shuffle_pairs;
}

main( $ARGV[0], $ARGV[1], $ARGV[2] );
