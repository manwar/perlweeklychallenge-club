#!/usr/bin/perl
use 5.030;
use warnings;

my $result = 0;

for my $i (0 .. scalar @ARGV - 3) {
    if ($ARGV[$i] % 2 && $ARGV[$i + 1] % 2 && $ARGV[$i + 2] % 2) {
        $result = 1;
        last;
    }
}

say $result;
