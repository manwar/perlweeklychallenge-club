#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main(@nums) {

    # Get the last number as the number to compare
    my $n = pop(@nums);

    # Get all numbers > n
    my @l = grep { $_ > $n } @nums;

    # Print the numbers
    say join( ', ', @l );
}

main(@ARGV);
