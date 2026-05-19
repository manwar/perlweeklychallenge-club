#!/usr/bin/perl
use strict;
use warnings;

sub most_frequent_letter_pair {
    my ($s) = @_;

    my %count;

    for my $i (0 .. length($s) - 2) {
        my $pair = substr($s, $i, 2);
        $count{$pair}++;
    }

    return "no such pair" unless %count;

    my $max = 0;
    for my $pair (keys %count) {
        $max = $count{$pair} if $count{$pair} > $max;
    }

    my @result = sort grep { $count{$_} == $max } keys %count;

    return $result[0];
}

# Tests

my $s;

# Example 1
$s = "abcdbca";
print most_frequent_letter_pair($s), "\n"; # Output: bc

# Example 2
$s = "cdeabeabfcdfabgcd";
print most_frequent_letter_pair($s), "\n"; # Output: ab
