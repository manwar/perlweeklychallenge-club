#! /usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

sub capital_detection ($string) {
    $string !~ /[[:lower:]][[:upper:]]/ ? 1 : 0
}

use Test::More tests => 4 + 1;

is capital_detection('Perl'), 1, 'Example 1';
is capital_detection('TPF'), 1, 'Example 2';
is capital_detection('PyThon'), 0, 'Example 3';
is capital_detection('raku'), 1, 'Example 4';

is capital_detection(""), 1, 'Empty';
