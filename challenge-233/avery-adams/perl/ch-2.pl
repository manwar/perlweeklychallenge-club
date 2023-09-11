#!/usr/bin/perl
use v5.36;

my %ints;
$ints{$_}++ foreach @ARGV;

my %ints_by_occurrence;
my @results;

foreach (keys %ints) {
    push @{$ints_by_occurrence{$ints{$_}}}, $_;
}
foreach (sort keys %ints_by_occurrence) {
    my $frequency = $_;
    foreach (sort {$b <=> $a} @{$ints_by_occurrence{$frequency}}) {
        my $number = $_;
        for (1..$frequency) {
            push @results, $number;
        }
    }
}
say $_ foreach @results;
