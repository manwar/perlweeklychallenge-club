#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-019/
# Task #1
# Write a script to accept a string from command line and split it on change of character.
# For example, if the string is "ABBCDEEF", then it should split like "A", "BB", "C", "D", "EE", "F".

use strict;
use warnings;

my $s = $ARGV[0] || 'ABBCDEEF';
while ($s =~ /(([A-Z])\2*)/g) { print "$1\n"; };
