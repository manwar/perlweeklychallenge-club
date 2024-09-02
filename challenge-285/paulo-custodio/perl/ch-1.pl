#!/usr/bin/env perl

# Challenge 285
#
# Task 1: No Connection
# Submitted by: Mohammad Sajid Anwar
#
# You are given a list of routes, @routes.
#
# Write a script to find the destination with no further outgoing connection.
# Example 1
#
# Input: @routes = (["B","C"], ["D","B"], ["C","A"])
# Output: "A"
#
# "D" -> "B" -> "C" -> "A".
# "B" -> "C" -> "A".
# "C" -> "A".
# "A".
#
# Example 2
#
# Input: @routes = (["A","Z"])
# Output: "Z"

use Modern::Perl;

my @routes = map {[split ' ', $_]} split /,/, "@ARGV";
say join ", ", endpoints(@routes);

sub endpoints {
    my(@routes) = @_;
    my %endpoints;
    for (@routes) {
        my($a, $b) = @$_;
        $endpoints{$b}=1;
    }
    for (@routes) {
        my($a, $b) = @$_;
        delete $endpoints{$a};
    }
    return sort keys %endpoints;
}
