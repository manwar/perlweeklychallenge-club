#!/usr/bin/perl
use strict;
use warnings;

sub odd_one_out {
    my ($words) = @_;

    return 0 unless @$words;  # empty array safeguard

    # Check same length
    my $len = length $words->[0];

    for my $w (@$words) {
        # check only lowercase a-z
        return "Invalid input" unless $w =~ /^[a-z]+$/;

        # check same length
        return "Invalid input" unless length($w) == $len;
    }

    my $count = 0;

    for my $word (@$words) {
        my @chars = split //, $word;

        for (my $i = 0; $i < @chars - 1; $i++) {
            if ($chars[$i] gt $chars[$i+1]) {
                $count++;
                last;  # only count word once
            }
        }
    }

    return $count;
}


# Tests

my @words;

# Example 1
@words = ('abc', 'xyz', 'tsu')
print odd_one_out(\words), "\n"; # Output: 1

# Example 21
@words = ('rat', 'cab', 'dad')
print odd_one_out(\words), "\n"; # Output: 3

# Example 3
@words = ('x', 'y', 'z')
print odd_one_out(\words), "\n"; # Output: 0
