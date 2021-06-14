#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use List::Util 'sum';

sub main {
    my $number = shift;

    die "The value is not a number >= 10\n" unless $number =~ /^[1-9][0-9]+(?:\.[0-9]*)?$/;

    # If number has a decimal point, remove it.
    $number =~ s/\.//;

    # Get the sun of all digits
    my $sum = sum( map { $_**2 } split //, $number );

    # Is this a square root of an integer
    my $s = sqrt $sum;
    say $s == int($s) ? 1 : 0;

}

main(@ARGV);

