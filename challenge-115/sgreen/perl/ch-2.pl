#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use List::MoreUtils 'lastidx';

sub main {
    my @numbers = sort { $b <=> $a } @_;

    # Find the position lowest even number
    my $index = lastidx { $_ % 2 == 0 } @numbers;

    if ( $index == -1 ) {
        # There is no solution
        say '0';
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
