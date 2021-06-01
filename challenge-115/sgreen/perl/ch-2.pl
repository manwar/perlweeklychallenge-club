#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use List::MoreUtils 'lastidx';

sub main {
    # Sort input in reverse order (highest value first)
    my @numbers = sort { $b cmp $a } @_;

    # Check that all inputs are a single digit (0 - 9)
    foreach (@numbers) {
        die "$_ is not a single digit\n" unless /^[0-9]$/;
    }

    # Find the position lowest even number
    my $index = lastidx { $_ % 2 == 0 } @numbers;

    if ( $index == -1 ) {
        # If there are no even numbers, there is no solution!
        say 'No solution';
        return;
    }
    elsif ( $index != $#numbers ) {
        # Remove the lowest even number, and put it at the end
        my $digit = splice( @numbers, $index, 1, () );
        push @numbers, $digit;
    }

    say join '', @numbers;
}

main(@ARGV);
