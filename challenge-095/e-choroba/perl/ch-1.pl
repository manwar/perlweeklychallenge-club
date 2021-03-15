#!/usr/bin/perl
use warnings;
use strict;

sub palindrome_number {
    my ($n) = @_;
    ($n eq reverse $n) ? 1 : 0
}

use Test::More tests => 4;

is palindrome_number(1221),  1, 'Example 1';
is palindrome_number(-101),  0, 'Example 2';
is palindrome_number(90),    0, 'Example 3';
is palindrome_number(12.21), 1, 'Float';
