#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    my $solutions = 0;

    while ( my ( $i, $value ) = each @ints ) {
        # Find future values that are less than half the current value
        $solutions +=
          scalar( grep { $value > $_ * 2 } @ints[ $i + 1 .. $#ints ] );
    }

    say $solutions;
}

main(@ARGV);