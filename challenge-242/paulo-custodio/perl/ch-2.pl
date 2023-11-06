#!/usr/bin/env perl

# Challenge 242
#
# Task 1: Missing Members
# Submitted by: Mohammad S Anwar
# You are given two arrays of integers.
#
# Write a script to find out the missing members in each other arrays.
#
# Example 1
# Input: @arr1 = (1, 2, 3)
#        @arr2 = (2, 4, 6)
# Output: ([1, 3], [4, 6])
#
# (1, 2, 3) has 2 members (1, 3) missing in the array (2, 4, 6).
# (2, 4, 6) has 2 members (4, 6) missing in the array (1, 2, 3).
# Example 2
# Input: @arr1 = (1, 2, 3, 3)
#        @arr2 = (1, 1, 2, 2)
# Output: ([3])
#
# (1, 2, 3, 3) has 2 members (3, 3) missing in the array (1, 1, 2, 2). Since they are same, keep just one.
# (1, 1, 2, 2) has 0 member missing in the array (1, 2, 3, 3).

use Modern::Perl;

@ARGV==1 or die "usage: $0 '([a, b, c], [d, e, f], [g, h, i])'\n";
my @m = parse(shift);

# a) Reverse each row
$_ = [reverse @$_] for @m;

# b) Invert each member
for (@m) {
    for (@$_) {
        $_ = 1-$_;
    }
}


say output(@m);


sub parse {
    my($text) = @_;
    my @m;
    my @rows = split /\]\s*,\s*\[/, $text;
    for (@rows) {
        s/\D/ /g;
        my @cols = split ' ', $_;
        push @m, \@cols;
    }
    return @m;
}

sub output {
    my(@m) = @_;
    my @elems;
    for (@m) {
        push @elems, "[".join(", ", @$_)."]"
    }
    return "(".join(", ", @elems).")";
}

