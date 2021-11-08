#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my $number = shift;

    # Sanity check
    die "You must specify a number\n" unless defined $number;
    die "The number must be a positive integer\n" unless $number =~ /^[1-9][0-9]*$/;

    while ( ++$number ) {
        if ( $number == reverse $number ) {
            # We have a Palindromic number
            say $number;
            return;
        }
    }
}

main(@ARGV);
