#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub clear_digits($str) {
    1 while $str =~ s/\D\d//;
    return $str
}

use Test::More tests => 3 + 1;

is clear_digits('cab12'), 'c', 'Example 1';
is clear_digits('xy99'), "", 'Example 2';
is clear_digits('pa1erl'), 'perl', 'Example 3';

is clear_digits('a12b'), '2b', 'Unremovable digit';
