#!/usr/bin/perl
use 5.40.1;
use warnings;

my ($arr1, $arr2) = @ARGV;
my @merged = sort { $a <=> $b } split /\s+/, trim "$arr1 $arr2";
my $len = scalar @merged;

if ($len % 2 == 0) {
    my $mid = $len / 2;
    say 0+($merged[$mid] + $merged[$mid - 1]) / 2;
} else {
    say $merged[$len / 2];
}
