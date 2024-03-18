#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(uniqueoccurrences([1, 2, 2, 1, 1, 3]), 1, 'example 1');
is(uniqueoccurrences([1, 2, 3]), 0, 'example 2');
is(uniqueoccurrences([-2, 0, 1, -2, 1, 1, 0, 1, -2, 9]), 1, 'example 3');

sub uniqueoccurrences($a) {
    my %c;
    map {$c{$_}++} @{$a};
    my %d = map {$_ => 1} values %c;
    if (scalar keys %d == scalar keys %c) {
        return 1;
    } else {
        return 0;
    }
}
