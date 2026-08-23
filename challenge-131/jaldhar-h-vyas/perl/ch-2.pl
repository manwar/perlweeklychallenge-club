#!/usr/bin/perl
use 5.40.1;
use warnings;

my ($delimiters, $search) = @ARGV;
my $opening;
my $closing;

for my ($key, $value) (indexed split //, $delimiters) {
    ($key % 2 ? $closing : $opening) .= $value;
}

say join q{}, ($search =~ /[\Q$opening\E]/g);
say join q{}, ($search =~ /[\Q$closing\E]/g);
