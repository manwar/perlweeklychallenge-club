#!/usr/bin/perl
use v5.38;

my @operations = @ARGV;
my $total = 0;

for my $operation (@operations) {
    if ($operation =~ /\+\+/) {
        $total++;
    }
    if ($operation =~ /\-\-/) {
        $total--;
    }
}

say $total;
