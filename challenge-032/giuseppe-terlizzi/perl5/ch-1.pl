#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-032/

# Task #1 - Count instances

# Create a script that either reads standard input or one or more files
# specified on the command-line. Count the number of times and then print a
# summary, sorted by the count of each entry.

# So with the following input in file example.txt

#   apple
#   banana
#   apple
#   cherry
#   cherry
#   apple

# the script would display something like:

#   apple     3
#   cherry    2
#   banana    1

# For extra credit, add a -csv option to your script, which would generate:

#   apple,3
#   cherry,2
#   banana,1

use strict;
use warnings;

use v5.10;
use Getopt::Long;

my $fh = *STDIN;
my $csv = 0;
my %data;

GetOptions("csv" => \$csv);

sub collect {

    while (<$fh>) {

        my $line = $_;
        chomp($line);

        $data{$line}++;

    }

    close $fh;

}

if (@ARGV) {

    foreach (@ARGV) {
        die "Input file not found ($_)\n" unless (-f $_);
        open $fh, '<', $_ or die ("$?\n");
        collect $fh
    }

} else {
    collect $fh;
}

foreach my $item (sort { $data{$b} <=> $data{$a} } keys %data) {
    printf "%s%s%s\n", $item, ($csv ? "," : "\t"), $data{$item};
}
