#!/usr/bin/env perl

use 5.026;
use strict;
use autodie;
use warnings;

# @ARGV should contain a list of numbers which I'll rank by magnitude.

# First I'll use a hash to count how many times each numbers occurs in @ARGV.

my %item_count;
++$item_count{$_} foreach @ARGV;

my @sorted_keys = sort {$a <=> $b} keys %item_count;

my $i;

print "Standard Ranking:";
$i = 1;
foreach my $key (@sorted_keys) {
    print " $i" x $item_count{$key};
    $i += $item_count{$key};
}
print "\n";

print "Modified Ranking:";
$i = 0;
foreach my $key (@sorted_keys) {
    $i += $item_count{$key};
    print " $i" x $item_count{$key};
}
print "\n";

print "   Dense Ranking:";
$i = 1;
foreach my $key (@sorted_keys) {
    print " $i" x $item_count{$key};
    $i += 1;
}
print "\n";
