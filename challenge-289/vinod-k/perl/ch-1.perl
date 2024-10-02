#!/usr/bin/perl

use strict;
use warnings;
use List::MoreUtils qw(uniq);

my @numbers = split(/\s+/, $ARGV[0]);

my @sorted_array = uniq(sort { $b <=> $a } @numbers);

my $size = scalar @sorted_array;

if ($size == 0){
    print "We need atleast one input..\n";
} elsif ($size == 1 || $size == 2) {
    print "We have $size elements in the given input, so answer is: $sorted_array[0]\n";
} else {
    print "We have $size elements in the given input, so answer is: $sorted_array[2]\n";
}