#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util qw(pairkeys sum);

sub main(@n) {
    # Sort the list numerical
    @n = sort { $a <=> $b} @n;

    # Return the sum of the the odd positioned items (1st, 3rd, 5th, ...)
    say sum(pairkeys(@n));
}

main(@ARGV);