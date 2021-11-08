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

    # Swap the bits around
    my $new_number = ( ( $number & 170 ) >> 1 ) + ( ( $number & 85 ) << 1 );
    say $new_number;
}

main(@ARGV);
