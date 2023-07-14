#!/usr/bin/perl

use strict;
use warnings;

my $limit = 20;
my $num   = 1;
my @abundant;

while ( @abundant < $limit ) {
    my $sum = 0;
    for my $i ( 1 .. $num - 1 ) {
        $sum += $i if $num % $i == 0;
    }

    if ( $sum > $num && $num % 2 != 0 ) {
        push @abundant, $num;
    }

    $num++;
}

print "@abundant\n";
