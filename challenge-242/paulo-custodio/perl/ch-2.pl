#!/usr/bin/env perl

# Challenge 242
#
# Task 2: Flip Matrix
# Submitted by: Mohammad S Anwar
# You are given n x n binary matrix.
#
# Write a script to flip the given matrix as below.
#
# 1 1 0
# 0 1 1
# 0 0 1
#
# a) Reverse each row
#
# 0 1 1
# 1 1 0
# 1 0 0
#
# b) Invert each member
#
# 1 0 0
# 0 0 1
# 0 1 1
#
# Example 1
# Input: @matrix = ([1, 1, 0], [1, 0, 1], [0, 0, 0])
# Output: ([1, 0, 0], [0, 1, 0], [1, 1, 1])
# Example 2
# Input: @matrix = ([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0])
# Output: ([1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0])

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
