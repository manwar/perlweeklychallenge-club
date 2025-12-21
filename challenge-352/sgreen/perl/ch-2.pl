#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util qw(notall);

sub main (@nums) {
    # Check all items are zero or one
    if ( notall { /^[01]$/ } @nums ) {
        die "Input list must contain only 0s and 1s\n";
    }

    my $current_binary = '';
    my @results        = ();

    foreach my $n (@nums) {
        # Add the next digit to the current binary number
        $current_binary .= $n;

        # Check if the current binary number is divisible by 5
        my $value = oct("0b$current_binary");
        push @results, $value % 5 == 0 ? 'true' : 'false';
    }

    # Return the list of results
    say '(', join( ', ', @results ), ')';
}

main(@ARGV);
