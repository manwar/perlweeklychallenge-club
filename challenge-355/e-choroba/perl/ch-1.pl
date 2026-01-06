#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub thousand_separator($int) {
    $int =~ s/(?<=.)(?=(?:...)+$)/,/gr
}

use Test::More tests => 5 + 2;

is thousand_separator(123), '123', 'Example 1';
is thousand_separator(1234), '1,234', 'Example 2';
is thousand_separator(1000000), '1,000,000', 'Example 3';
is thousand_separator(1), '1', 'Example 4';
is thousand_separator(12345), '12,345', 'Example 5';

is thousand_separator(123456), '123,456', '6 digits';
is thousand_separator(12345678), '12,345,678', '7 digits';
