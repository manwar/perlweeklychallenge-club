#!/usr/bin/perl
# Test: cat example.txt | ./ch1.pl

use strict;
use warnings;
use Getopt::Long;

my $use_csv = 0;
my %counts;

GetOptions ("csv" => \$use_csv);

# Increment the counts hash for each line
for my $line ( <STDIN> ) {
    chomp($line);
    $counts{$line}++;
}

# Print the aggregated line items
for my $item (sort keys %counts) {
    if ($use_csv) {
        # Normally i'd use a module like Text::CSV
        print $item . ',' . $counts{$item};
    } else {
        printf("%-10s %d", $item, $counts{$item})
    }
    print "\n";
}
