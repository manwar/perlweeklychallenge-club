#!/usr/bin/env perl
use v5.40;

# make a hash of all the possible values from 1 to @ARGV
my %missing = map { $_ => 1 } 1..@ARGV;

# delete any elements in @ARGV
delete $missing{$_} for @ARGV;

# print out any remaining keys
printf "(%s)\n", join ", ", sort { $a <=> $b } keys %missing;
