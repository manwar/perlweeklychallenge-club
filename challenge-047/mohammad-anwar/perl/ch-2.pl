#!/usr/bin/perl

use strict;
use warnings;

my $start = 99;
my $count = 0;

while ($count <= 20) {
    $start++;

    my ($d1, $d2, $d3) = split //, $start;
    my $divisor = sprintf("%d%d", $d1, $d3);

    if ($start % $divisor != 0) {
        next;
    }
    else {
        $count++;
        print sprintf("%d / %d\n", $start, $divisor);
    }
}
