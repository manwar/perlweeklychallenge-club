#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my $N = shift;

    # Sanity check
    die "You must specify a positive integer\n"               unless defined $N;
    die "The value doesn't appear to be a positive integer\n" unless $N =~ /^[1-9][0-9]*$/;

    # We do this the crude way
    my $isqrt = 1;
    $isqrt++ while ( $isqrt + 1 )**2 <= $N;

    # Display the result
    say $isqrt;
}

main(@ARGV);
