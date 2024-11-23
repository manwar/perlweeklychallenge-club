#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub string_compression($chars) {
    $chars =~ s/((.)\2+)/length($1) . $2/reg
}

sub string_decompression($compressed) {
    $compressed =~ s/([0-9]+)(.)/$2 x $1/reg
}

use Test::More tests => 3 + 3 + 2;

is string_compression('abbc'), 'a2bc', 'Example 1';
is string_compression('aaabccc'), '3ab3c', 'Example 2';
is string_compression('abcc'), 'ab2c', 'Example 3';

is string_decompression('a2bc'), 'abbc', 'Decompression Example 1';
is string_decompression('3ab3c'), 'aaabccc', 'Decompression Example 2';
is string_decompression('ab2c'), 'abcc', 'Decompression Example 3';

is string_compression('baaaaaaaaaaab'), 'b11ab', 'More than 9';
is string_decompression('b11ab'), 'baaaaaaaaaaab', 'More than 9 back';
