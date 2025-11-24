#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ max };

sub power_string($str) {
    my $l = 0;
    $l < length $1 and $l = length $1 while $str =~ /((.)\2*)/g;
    return $l
}

use Test::More tests => 5 + 1;

is power_string('textbook'), 2, 'Example 1';
is power_string('aaaaa'), 5, 'Example 2';
is power_string('hoorayyy'), 3, 'Example 3';
is power_string('x'), 1, 'Example 4';
is power_string('aabcccddeeffffghijjk'), 4, 'Example 5';

is power_string(""), 0, 'Zero';
