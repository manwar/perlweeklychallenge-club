#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my ( $number, $bit ) = @_;

    # Sanity check
    die "You must specify two values\n"                             unless defined $number and defined $bit;
    die "The first value doesn't appear to be a positive integer\n" unless $number =~ /^[1-9][0-9]*$/;
    die "The first value has to be less than 256\n"                 unless $number < 256;
    die "The second value needs to be between 1 and 8\n"            unless $bit =~ /^[1-8]/;

    # Flip the nth bit from the right
    say $number ^ 2**( $bit - 1 );
}

main(@ARGV);
