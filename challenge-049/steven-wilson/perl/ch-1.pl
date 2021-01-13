#!/usr/bin/env perl
# Steven Wilson
# Challenge 049 Task #1
# 24 Feb 2020

# Smallest Multiple

# Write a script to accept a positive number as command line argument
# and print the smallest multiple of the given number consists of digits
# 0 and 1.

# For example:
# For given number 55, the smallest multiple is 110 consisting of digits
# 0 and 1.

use strict;
use warnings;
use feature qw/ say /;

my $number     = $ARGV[0];
my $mulitplier = 1;
my $smallest_multiple;

while (1) {
    my $mulitple = $mulitplier * $number;
    if ( $mulitple =~ /^[01]*$/ ) {
        $smallest_multiple = $mulitple;
        last;
    }
    $mulitplier++;
}

say $smallest_multiple;
