#!/usr/bin/env perl
# Perl weekly challenge 310
# Task 1:  Arrays Intersection
#
# See https://wlmb.github.io/2025/02/24/PWC310/#task-1-arrays-intersection
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to find the intersection of the sets S0, S1..., represented by
    space separated strings.
    FIN
my %seen;
for(@ARGV){
    my %set;
    $set{$_}=1 for split " ", $_;
    my @unique = keys %set;
    $seen{$_}++ for @unique;
}
my @intersection = grep {$seen{$_} == @ARGV} keys %seen;
say map("[$_] ", @ARGV)," -> [", join(" ", @intersection), "]";
