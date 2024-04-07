#!/usr/bin/perl
use 5.030;
use warnings;


my @ints = @ARGV;

my $positive = 0;
my $negative = 0;

for my $n (@ints) {
    if ($n > 0) {
        $positive++;
    } elsif ($n < 0) {
        $negative++;
    }
}

say 0+($positive > $negative) ? $positive : $negative;

