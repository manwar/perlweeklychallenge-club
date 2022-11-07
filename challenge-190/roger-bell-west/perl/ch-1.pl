#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 4;

is(capitaldetection("Perl"), 1, 'example 1');
is(capitaldetection("TPF"), 1, 'example 2');
is(capitaldetection("PyThon"), 0, 'example 3');
is(capitaldetection("raku"), 1, 'example 4');

sub capitaldetection($s) {
    if ($s =~ /^([A-Z]+|[a-z]+|[A-Z][a-z]+)$/) {
        return 1;
    } else {
        return 0;
    }
}
