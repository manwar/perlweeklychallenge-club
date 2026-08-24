#!/usr/bin/perl
use 5.40.1;
use warnings;

my ($str) = @ARGV;

my $steps = 0;

while ($str =~ s/01/10/g) {
    $stepst++;
}

say $steps;