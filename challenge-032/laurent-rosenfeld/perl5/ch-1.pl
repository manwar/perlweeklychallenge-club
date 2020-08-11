#!/usr/bin/perl
use strict;
use warnings;

my %histo;
while (<>) {
    chomp;
    s/\s+$//;
    next if /^\s*$/; # skipping empty lines
    $histo{$_}++;
}
for my $key (sort { $histo{$b} <=> $histo{$a} } keys %histo) {
    printf "%-20s%d\n", $key, $histo{$key};
}
