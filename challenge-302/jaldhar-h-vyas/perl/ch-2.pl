#!/usr/bin/perl
use v5.38;

my @ints = @ARGV;
my $min = 0;
my $current = 0;

for my $n (@ints) {
    $current += $n;
    if ($current < $min) {
        $min = $current;
    }
}

say 1 - $min;
