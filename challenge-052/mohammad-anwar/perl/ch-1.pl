#!/usr/bin/perl

use strict;
use warnings;

my $start = $ARGV[0] || 100;
my $stop  = $ARGV[1] || 999;

die "ERROR: Invalid start number [$start]\n"
    unless ($start >= 100 &&
            $start <= 999);
die "ERROR: Invalid stop  number [$stop]\n"
    unless ($start <= $stop &&
            $stop  >= 100   &&
            $stop  <= 999);

while ($start <= $stop) {
    my ($d1, $d2, $d3) = split //, $start, 3;
    if ( ((($d1 - $d2) == 1) && (($d2 - $d3) == 1))
         || ((($d2 - $d1) == 1) && (($d3 - $d2) == 1)) ) {
        print "$start\n";
    }
    $start++;
}
