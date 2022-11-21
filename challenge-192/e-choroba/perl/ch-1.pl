#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

sub binary_flip ($n) { ~ $n & (2 ** (log ($n) / log 2) - 1) }

use Test::More tests => 3 + 2;

is binary_flip(5), 2, 'Example 1';
is binary_flip(4), 3, 'Example 2';
is binary_flip(6), 1, 'Example 3';

is binary_flip(255), 0, '1x8';
is binary_flip(256), 255, '1 . 0x8';
