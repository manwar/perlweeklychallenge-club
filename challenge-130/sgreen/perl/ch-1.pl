#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my @N = @_;

    my %count = ();
    $count{$_}++ foreach @N;

    my @odd = grep { $count{$_} % 2 } keys %count;

    # Display the results
    if ( $#odd == -1 ) {
        say "No numbers appear an odd number of times\n";
    }
    else {
        say join ', ', @odd;
    }
}

main(@ARGV);
