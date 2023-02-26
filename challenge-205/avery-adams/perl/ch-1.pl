#!/usr/bin/perl

use strict;
use warnings;

use Scalar::Util;

my @nums;

foreach (@ARGV) {
    if (Scalar::Util::looks_like_number($_)) {
        push @nums, $_;
    }
}

if (@nums) {
    my @sorted_nums = sort { $b <=> $a } @nums;
    my $count = 0;
    foreach (@sorted_nums) {
        if ($count > 0) {
            if ($sorted_nums[$count] == $sorted_nums[$count - 1]) {
                splice @sorted_nums, $count, 1;
                $count--;
            }
        }
        $count++;
    }
    if (@sorted_nums >= 3) {
        print $sorted_nums[2] . "\n";
    } else {
        print $sorted_nums[0] . "\n";
    }
} else {
    print "I couldn't find any numbers in what you provided. \n";
}

