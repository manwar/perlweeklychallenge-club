#!/usr/bin/perl
use 5.030;
use warnings;

my $result = -1;

for my $i (0 .. scalar @ARGV - 1) {
    if ($ARGV[$i] % 10 == $i) {
        $result = $i;
        last;
    }
}

say $result;
