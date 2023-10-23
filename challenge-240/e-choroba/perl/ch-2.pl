#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub build_array(@int) { [@int[@int]] }

use Test2::V0;
plan 2;

is build_array(0, 2, 1, 5, 3, 4), [0, 1, 2, 4, 5, 3], 'Example 1';
is build_array(5, 0, 1, 2, 3, 4), [4, 5, 0, 1, 2, 3], 'Example 2';
