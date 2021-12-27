#!/usr/bin/perl
use warnings;
use strict;
use experimental qw{ signatures bitwise };

my @MASK = ("\x00", "\xFF");
sub like_numbers ($digits, $divisor) {
    my $length = length $digits;
    my $count = 0;
    for my $indicator (1 .. 2 ** $length - 2) {
        my $mask = sprintf('%0*b', $length, $indicator)
                 =~ s/(.)/$MASK[$1]/gr;
        my $candidate = ($mask &. $digits) =~ tr/\x00//dr;
        ++$count if 0 == $candidate % $divisor;
    }
    return $count
}

use Test2::V0;
plan 2;

is like_numbers(1234, 2), 9, 'Example 1';
is like_numbers(768, 4), 3, 'Example 2';
