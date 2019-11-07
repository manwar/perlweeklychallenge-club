#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-033/
# Task #1
# Count Letters (A..Z)
#
# Create a script that accepts one or more files specified on the command-line
# and count the number of times letters appeared in the files.
#
# So with the following input file sample.txt
# The quick brown fox jumps over the lazy dog.
# the script would display something like:
#
# a: 1
# b: 1
# c: 1
# ...
# y: 1
# z: 1

use strict;
use warnings;

my %times;
while (<>) {
    chomp;
    my @letters = grep { /[a-z]/i } split //; # retain only letters from each line
    $times{lc $_}++ for @letters;             # count case-insensitive letter repetition
}

for ('a' .. 'z') {
    print $_,': ', $times{$_} || 0, "\n";
}
