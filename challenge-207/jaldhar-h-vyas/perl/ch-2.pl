#!/usr/bin/perl
use 5.030;
use warnings;

my $hindex = 0;

for my $h (1 .. scalar @ARGV) {
    if ($ARGV[$h - 1] < $h) {
        last;
    }
    $hindex = $h;
}

say $hindex;
