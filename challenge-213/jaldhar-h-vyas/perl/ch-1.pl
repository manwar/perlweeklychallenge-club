#!/usr/bin/perl
use 5.030;
use warnings;

my @list = @ARGV;
my @odd;
my @even;

for my $i (@list) {
    if ($i % 2 == 0) {
        push @even, $i;
    } else {
        push @odd, $i;
    }
}

my @results = sort { $a <=> $b} @even;
push @results, sort { $a <=> $b } @odd;

say q{(}, (join q{,}, @results), q{)};
