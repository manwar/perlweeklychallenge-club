#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(samestring(['ab', 'c'], ['a', 'bc']), 1, 'example 1');
is(samestring(['ab', 'c'], ['ac', 'b']), 0, 'example 2');
is(samestring(['ab', 'cd', 'e'], ['abcde']), 1, 'example 3');

sub samestring($a, $b) {
    return join('', @{$a}) eq join('', @{$b})?1:0;
}
