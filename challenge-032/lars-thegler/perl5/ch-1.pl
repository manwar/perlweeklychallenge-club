#!/usr/bin/env perl

use Modern::Perl;

# Task #1
# Contributed by Neil Bowers
# Count instances
# Create a script that either reads standard input or one or more files specified on the command-line. Count the number of times and then print a summary, sorted by the count of each entry.

# So with the following input in file example.txt

# apple
# banana
# apple
# cherry
# cherry
# apple
# the script would display something like:

# apple     3
# cherry    2
# banana    1
# For extra credit, add a -csv option to your script, which would generate:

# apple,3
# cherry,2
# banana,1

use Getopt::Long;
GetOptions("csv" => \my $csv) or die;

my %count;
while (<>) {
    chomp;
    $count{$_}++;
}

my $delim = $csv ? ',' : "\t";
for my $k (sort keys %count) {
    say "$k$delim$count{$k}";
}