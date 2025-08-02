#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    my $solution = 0;
    my $length   = scalar(@ints);

    foreach my $pos ( 0 .. $#ints ) {
        if ( $length % ( $pos + 1 ) == 0 ) {
            # This is a special number. Add its square to the solution
            $solution += $ints[$pos]**2;
        }
    }

    say $solution;
}

main(@ARGV);