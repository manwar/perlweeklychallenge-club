#!/usr/bin/perl
use 5.40.1;
use warnings;

my @nums = @ARGV;

my $current = 1;
my $longest = $current;
my $direction = 0;

for my $i (1 .. scalar @nums - 1) {
    my $difference = $nums[$i] <=> $nums[$i - 1];

    if ($difference == 0) {
        $current = 1;
        $direction = 0;
    } elsif ($difference == -$direction) {
        $current++;
        $direction = $difference;
    } else {
        $current = 2;
        $direction = $difference;
    }

    if ($current > $longest) {
        $longest = $current;
    }
}

say $longest;
