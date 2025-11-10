#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub format_phone_number($phone) {
    s/[- ]//g,                              # Remove spaces and dashes.
    s/(...)/$1-/g,                          # Groups of 3.
    s/-(.?)$/$1/,                           # - or -1 at the end.
    s/(^|-)([0-9]{2})([0-9]{2})$/$1$2-$3/   # Split groups of 4 at the end.
        for $phone;

    return $phone
}

use Test::More tests => 5;

is format_phone_number('1-23-45-6'), '123-456', 'Example 1';
is format_phone_number('1234'), '12-34', 'Example 2';
is format_phone_number('12 345-6789'), '123-456-789', 'Example 3';
is format_phone_number('123 4567'), '123-45-67', 'Example 4';
is format_phone_number('123 456-78'), '123-456-78', 'Example 5';
