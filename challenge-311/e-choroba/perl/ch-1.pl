#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub upper_lower($str) { $str =~ tr/a-zA-Z/A-Za-z/r }

use Test::More tests => 3;

is upper_lower('pERl'), 'PerL', 'Example 1';
is upper_lower('rakU'), 'RAKu', 'Example 2';
is upper_lower('PyThOn'), 'pYtHoN', 'Example 3';
