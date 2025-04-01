#!/usr/bin/perl
use v5.38;

sub min($first, $second) {
    return $first < $second ? $first : $second;
}

my $str = shift;
my $time = 0;
my $current = 'a';

for my $char (split //, $str) {
    my $distance = abs(ord($char) - ord($current));
    $time += min($distance, 26 - $distance) + 1;
    $current = $char;
}

say $time;
