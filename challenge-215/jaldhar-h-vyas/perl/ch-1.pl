#!/usr/bin/perl
use 5.030;
use warnings;

my @words = @ARGV;

my $removals = 0;

for my $word (@words) {
    my $sorted = join q{}, (sort (split //, $word));
    if ($word ne $sorted) {
        $removals++;
    }
}

say $removals;
