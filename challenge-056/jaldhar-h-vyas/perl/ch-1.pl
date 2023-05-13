#!/usr/bin/perl
use 5.010;
use warnings;
use strict;

my ($k, @N) = @ARGV;

for my $i (0 .. scalar @N - 1) {
    for my $j (0 .. scalar @N - 1) {
        if ($N[$i] - $N[$j] == $k && $i != $j) {
            say "$i,$j";
        }
    }
}
