#!/usr/bin/perl
use warnings;
use strict;

my ($i, $p, $e) = (1) x 3;
my $old_e = 0;

while ($old_e != $e) {
    $old_e = $e;
    $p *= $i++;
    $e += 1 / $p;
}

use Test::More tests => 1;
is $e, exp 1;
