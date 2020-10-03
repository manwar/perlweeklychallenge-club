#!/usr/bin/perl

use strict;
use warnings;

die "usage: ./ch-1.pl [space seperated numbers]\n"
    unless scalar @ARGV;

my @sorted = sort { $a <=> $b } @ARGV;

# Print 1 if there are no positive numbers in @sorted.
print "1\n" and exit 0 if $sorted[$#sorted] < 1;

while (my $arg = shift @sorted) {
    next if $arg < 2;
    print "2\n" and exit 0 unless $arg == 2;
    last;
}

MAIN: foreach my $num (3 ... $sorted[$#sorted] + 1) {
    foreach (@sorted) {
        shift @sorted and next MAIN if $num == $_;
        print "$num\n" and last MAIN;
    }
    # Print the last element if it was a continous series of positive
    # numbers.
    print "$num\n";
}
