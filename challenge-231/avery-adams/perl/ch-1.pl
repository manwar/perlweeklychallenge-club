#!/usr/bin/perl
use v5.36;

my %hist;
$hist{$_} = 1 for @ARGV;

say "You didn't provide two or more arguments." and exit if scalar keys %hist < 2;
say "-1" and exit if scalar keys %hist == 2;

my ($max, $min);
for (keys %hist) {
    $max = $_ if (!defined($max) || $_ > $max);
    $min = $_ if (!defined($min) || $_ < $min);
}
for (keys %hist) {
    say $_ if $_ != $max and $_ != $min;
}
