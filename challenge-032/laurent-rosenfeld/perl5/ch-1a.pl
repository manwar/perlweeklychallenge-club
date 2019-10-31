#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

my %histo;
my $csv_flag = shift;

while (<>) {
    chomp;
    s/\s+$//;
    next if /^\s*$/; # skipping empty lines
    $histo{$_}++;
}
my $format = $csv_flag ? "%s,%d\n" : "%-20s%d\n";

for my $key (sort { $histo{$b} <=> $histo{$a} } keys %histo) {
    printf $format, $key, $histo{$key};
}
