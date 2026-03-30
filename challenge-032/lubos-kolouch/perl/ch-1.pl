#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long;

=head1 NAME

CountInstances - Count occurrences of items from input

=head1 SYNOPSIS

    perl ch-1.pl [options] [file ...]

    Options:
        -csv    Output in CSV format

    If no files are given, reads from STDIN.

=head1 DESCRIPTION

Count the number of times each unique line appears in the input.
Output sorted by count (descending) or alphabetically.

=cut

my $csv_output = 0;
GetOptions('csv' => \$csv_output) or die "Error in command line arguments\n";

my %count;

# Read from files or STDIN
while (my $line = <>) {
    chomp $line;
    $count{$line}++;
}

# Output
my $sep = $csv_output ? ',' : "\t";

# Sort by count (descending), then alphabetically
for my $key (sort { $count{$b} <=> $count{$a} || $a cmp $b } keys %count) {
    print "$key$sep$count{$key}\n";
}

=head1 EXAMPLES

    # Count from file
    perl ch-1.pl example.txt

    # Count from STDIN
    echo -e "apple\nbanana\napple\ncherry" | perl ch-1.pl

    # CSV output
    perl ch-1.pl -csv example.txt

=cut
