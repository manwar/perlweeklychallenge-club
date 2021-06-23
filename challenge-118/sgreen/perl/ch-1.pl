#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my $number = shift;

    # Sanity check
    die "You must specify a number\n" unless defined $number;
    die "The value does not appear to be a positive integer\n" unless $number =~ /^[1-9][0-9]*$/;

    # Turn the value into a binary string
    my $bin = sprintf '%b', $number;

    say $bin eq reverse($bin) ? 1 : 0;
}

main(@ARGV);
