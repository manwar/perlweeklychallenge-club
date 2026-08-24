#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use ntheory qw{ subfactorial };

sub secret_santa($n) { subfactorial($n) }

use Test::More tests => 5;

is secret_santa(1), 0, 'Example 1';
is secret_santa(2), 1, 'Example 2';
is secret_santa(3), 2, 'Example 3';
is secret_santa(4), 9, 'Example 4';
is secret_santa(5), 44, 'Example 5';
