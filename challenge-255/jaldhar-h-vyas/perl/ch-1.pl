#!/usr/bin/perl
use 5.030;
use warnings;

my ($s, $t) = @ARGV;
my %chars;

for my $c (split //, $t) {
    $chars{$c}++;
}

for my $c (split //, $s) {
    $chars{$c}--;
}

say q{"}, (join q{}, grep { $chars{$_} > 0 } keys %chars), q{"};