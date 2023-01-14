#!/usr/bin/perl
use 5.030;
use warnings;

my @list = @ARGV;
my @goodpairs;

for my $i (0 .. scalar @list - 1) {
    for my $j ($i + 1 .. scalar @list - 1) {
        if ($list[$j] == $list[$i]) {
            push @goodpairs, [$i, $j];
        }
    }
}

say scalar @goodpairs;
