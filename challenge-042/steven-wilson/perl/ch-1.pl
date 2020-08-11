#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2020-01-08
# Week: 042
# Task #1
# Octal Number System
# Write a script to print decimal number 0 to 50 in Octal Number System.

# For example:

# Decimal 0 = Octal 0
# Decimal 1 = Octal 1
# Decimal 2 = Octal 2
# Decimal 3 = Octal 3
# Decimal 4 = Octal 4
# Decimal 5 = Octal 5
# Decimal 6 = Octal 6
# Decimal 7 = Octal 7
# Decimal 8 = Octal 10

use strict;
use warnings;
use feature qw/ say /;
use Test::More tests => 1;

ok( decimal_to_octal(1792) == 3400, "test decimal 1792 is octal 3400" );

sub decimal_to_octal {
    my $dec = shift;
    my $result;
    while ( $dec > 7 ) {
        $result .= $dec % 8;
        $dec = int( $dec / 8 );
    }
    $result .= $dec;
    return scalar reverse $result;
}

for ( 0 .. 50 ) {
    say "Decimal $_ = Octal ", decimal_to_octal($_);
}
