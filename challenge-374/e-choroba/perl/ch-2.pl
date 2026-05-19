#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub largest_same_digits_number($str) {
    my $r = -1;
    while ($str =~ /((.)\2*)/g) {
        $r = $1 if $r < $1;
    }
    return 0 + $r
}

use Test::More tests => 5 + 1;

is largest_same_digits_number('6777133339'), 3333, 'Example 1';
is largest_same_digits_number('1200034'), 4, 'Example 2';
is largest_same_digits_number('44221155'), 55, 'Example 3';
is largest_same_digits_number('88888'), 88888, 'Example 4';
is largest_same_digits_number('11122233'), 222, 'Example 5';

is largest_same_digits_number('0000'), 0, 'Zeros';
