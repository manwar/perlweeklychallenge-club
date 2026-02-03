#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub string_reduction($word) {
    1 while $word =~ s/(.)\1//g;
    return $word
}

use Test::More tests => 5;

is string_reduction('aabbccdd'), "", 'Example 1';
is string_reduction('abccba'), "", 'Example 2';
is string_reduction('abcdef'), 'abcdef', 'Example 3';
is string_reduction('aabbaeaccdd'), 'aea', 'Example 4';
is string_reduction('mississippi'), 'm', 'Example 5';
