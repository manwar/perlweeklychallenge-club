#!/usr/bin/env perl

# Challenge 183
#
# Task 1: Unique Array
# Submitted by: Mohammad S Anwar
#
# You are given list of arrayrefs.
#
# Write a script to remove the duplicate arrayrefs from the given list.
# Example 1
#
# Input: @list = ([1,2], [3,4], [5,6], [1,2])
# Output: ([1,2], [3,4], [5,6])
#
# Example 2
#
# Input: @list = ([9,1], [3,7], [2,5], [2,5])
# Output: ([9, 1], [3,7], [2,5])

use Modern::Perl;

sub remove_dups {
    my(@a) = @_;
    my %seen;
    @a = grep {!$seen{"@$_"}++} @a;
    return @a;
}

my @in = map {[split /,/, $_]} @ARGV;
my @out = remove_dups(@in);
say "(",(join ", ", map {"[".join(",", @$_)."]"} @out),")";
