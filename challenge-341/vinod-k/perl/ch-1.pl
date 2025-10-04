#!/usr/bin/perl

use strict;
use warnings;

# Read sentence from standard input
print("Enter the sentence:\n");
chomp(my $str = <STDIN>);

# Read broken keys as space-separated input from standard input
print("Enter the broken keys as space-separated:\n");
chomp(my $keys_line = <STDIN>);
my @keys = split /\s+/, $keys_line;

my %broken = map { lc($_) => 1 } @keys;
my @words = split /\s+/, $str;

my $count = 0;
foreach my $word (@words) {
    my $can_type = 1;
    foreach my $char (split //, lc($word)) {
        if ($broken{$char}) {
            $can_type = 0;
            last;
        }
    }
    $count++ if $can_type;
}

print "$count\n";
