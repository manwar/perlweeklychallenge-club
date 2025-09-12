#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@numbers) {
    my @solution = ();

    foreach my $number (@numbers) {
        # Count how many numbers are smaller or equal than the current number.
        # Subtract one to exclude the current number itself.
        my $count = grep { $_ <= $number } @numbers;
        push @solution, $count - 1;
    }

    say '(' . join(', ', @solution) . ')';
}

main(@ARGV);