#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-10-28
# Week: 032

# Task #1

# Count instances
# Create a script that either reads standard input or one or more files
# specified on the command-line. Count the number of times and then
# print a summary, sorted by the count of each entry.
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

use strict;
use warnings;
use feature qw/ say /;

my %word_count;
my $delimiter = "\t";
if ( $ARGV[0] eq "-csv" ) {
    shift @ARGV;
    $delimiter = ",";
}

for my $file (@ARGV) {
    open my $fh, '<', $file or die "Can't open < $file: $!";
    while ( !eof $fh ) {
        my $word = readline $fh;
        chomp $word;
        $word_count{$word} += 1;
    }
}

my @word_count_desc
    = reverse sort { $word_count{$a} <=> $word_count{$b} } keys %word_count;

for my $word (@word_count_desc) {
    say "$word$delimiter$word_count{$word}";
}
