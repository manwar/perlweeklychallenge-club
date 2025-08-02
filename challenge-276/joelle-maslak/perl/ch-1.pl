#!/usr/bin/perl

use v5.34;
use strict;
use warnings;

MAIN: {
    my $hourstr = join " ", @ARGV;
    $hourstr =~ s/[(),]/ /g;
    $hourstr =~ s/^\s*(.*)\s*$/$1/g;
    my (@hours) = split /\s+/, $hourstr;

    my %pairs;
    for (my $i=0; $i+1<scalar(@hours); $i++) {
        for (my $j=$i+1; $j<scalar(@hours); $j++) {
            if (!(($hours[$i] + $hours[$j]) % 24)) {
                $pairs{join ":", sort($hours[$i], $hours[$j])} = 1;
            }
        }
    }

    say scalar(keys(%pairs));
}