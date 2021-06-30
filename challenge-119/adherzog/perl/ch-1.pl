#!/usr/bin/env perl

##############################################################################
# Perl Weekly Challenge #119
##############################################################################
#
# Task #1 - Swap Nibbles
#
# You are given a positive integer $N.
#
# Write a script to swap the two nibbles of the binary representation of the
# given number and print the decimal number of the new binary representation.
#
# > A nibble is a four-bit aggregation, or half an octet.
#
##############################################################################

use strict;
use warnings;
use v5.10;

use Test::More;

if (@ARGV) {
    say swap_nibbles(@ARGV);
}
else {
    my @tests = (
        { input => 101, output => 86, },
        { input => 18,  output => 33, },

        { input => 255, output => 255, },
    );

    for my $test (@tests) {
        is( swap_nibbles( $test->{'input'} ), $test->{'output'}, );
    }

    done_testing();
}

exit;

##############################################################################
# We could convert the number into a binary string, and use substr or a regex
# to extract the nibbles, concatanate them together and then convert back into
# decimal.
#
# Instead, we'll use bit manipulation.
#
# & is bitwise AND. Using $N & 0xF0 gives us the high nibble. $N & 0x0F gives
# us the low nibble.
#
# << and >> are bit shift operators. Shifting by 4 can convert the high nibble
# into the low, and vice versa.
#
# Then recombine with a bitwise OR (|).
#
##############################################################################

sub swap_nibbles {
    my $N = shift;
    return ( ( $N & 0xF0 ) >> 4 ) | ( ( $N & 0x0F ) << 4 );
}
