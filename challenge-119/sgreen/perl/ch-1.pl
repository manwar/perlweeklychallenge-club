#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my $number = shift;

    # Sanity check
    die "You must specify a positive integer\n"               unless defined $number;
    die "The value doesn't appear to be a positive integer\n" unless $number =~ /^[1-9][0-9]*$/;
    die "The value has to be less than 256\n"                 unless $number < 256;

    say +( $number >> 4 ) + ( $number & 15 ) * 16;
}

main(@ARGV);
