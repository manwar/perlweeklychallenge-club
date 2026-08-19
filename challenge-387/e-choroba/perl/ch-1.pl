#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub rearrange_binary_string($str) {
    my $tally = 0;
    ++$tally while $str =~ s/01/10/g;
    return $tally
}

use Test::More tests => 5;

is rearrange_binary_string('111000'), 0, 'Example 1';
is rearrange_binary_string('00011'), 4, 'Example 2';
is rearrange_binary_string('01011'), 3, 'Example 3';
is rearrange_binary_string('010101'), 3, 'Example 4';
is rearrange_binary_string('00001'), 4, 'Example 5';
