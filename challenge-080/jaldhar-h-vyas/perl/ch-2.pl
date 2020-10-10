#!/usr/bin/perl
use 5.020;
use warnings;

my @N = @ARGV;
my @candies = map{ 1; } @N;

for my $i (0 .. scalar @N - 1) {
    if ($N[$i] > ($N[$i - 1] // 'inf')) {
        $candies[$i]++;
    }
    if ($N[$i] > ($N[$i + 1] // 'inf')) {
        $candies[$i]++;
    }
}

my $total = 0;
foreach (@candies) {
    $total += $_;
}
say $total;
