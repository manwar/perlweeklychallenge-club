#!/usr/bin/perl

use strict;
use warnings;

use Scalar::Util;

my @nums;
my @permuted;
my $index1 = 0;
my $index2 = 1;

foreach (@ARGV) {
    if (Scalar::Util::looks_like_number($_)) {
        push @nums, $_;
    }
}

if (@nums) {
    foreach (@nums) {
        while ($index2 < @nums) {
            push @permuted, (int($nums[$index1]) ^ int($nums[$index2]));
            $index2++;
        }
        $index1++;
        $index2 = $index1 + 1;
    }
    my @sorted = sort { $b <=> $a } @permuted;
    print ($sorted[0] . "\n");
} else {
    print "I couldn't find any numbers in what you provided. \n";
}