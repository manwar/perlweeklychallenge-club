#!/usr/bin/env perl

use strict;
use warnings;

use feature 'say';
use List::Util qw(product);

sub main {
    my @N = @_;

    # Check that we have integers
    die "You must specify one or more integers\n" unless scalar(@N);
    foreach (@N) {
        die "The value '$_' does not appear to be a positive integer\n"
          unless /^\d+$/;
    }

    # Special case if there is only one number
    if ( scalar(@N) == 1 ) {
        say '0';
        return;
    }

    # Calculate the product of all numbers
    my $product = product(@N);

    # The solution for each number is product divided by the number
    say join ', ', map { $product / $_ } @N;
}

main(@ARGV);
