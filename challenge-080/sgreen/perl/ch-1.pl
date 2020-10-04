#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my @input = @_;

    # Sanity checks
    die "You must supply one or more integers\n" unless @input;
    foreach (@input) {
        die "The vale '$_' is not an integer\n" unless /^-?[0-9]+$/;
    }

    # Put the values in a hash for faster look up
    my %seen = ( map { $_, undef } @input );

    # Count from one until we find a value that is not in %seen
    my $result = 1;
    $result++ while exists $seen{$result};

    # Display the result
    say $result;
}

main(@ARGV);
