#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 1;

is(friday13th(2023), 2, 'example 1');

use Time::Local qw(timegm_modern);

sub friday13th($y) {
    my $f = 0;
    foreach my $m (1 .. 12) {
        if ((gmtime(timegm_modern(0, 0, 12, 13, $m - 1, $y)))[6] == 5 ) {
            $f++;
        }
    }
    return $f;
}
