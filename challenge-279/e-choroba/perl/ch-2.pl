#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub split_string($string) {
    my $tally = $string =~ tr/aeiou//;
    return 0 == $tally % 2
}

use Test::More tests => 3;

ok ! split_string('perl'),         'Example 1';
ok   split_string('book'),         'Example 2';
ok   split_string('good morning'), 'Example 3';
