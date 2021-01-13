#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);
use autodie;

# TASK #2 › Lines Range
# Submitted by: Mohammad S Anwar
#
# You are given a text file name $file and range $A - $B where $A <= $B.
#
# Write a script to display lines in the given file in the line number
# range between $A and $B, inclusive.

my ($fname, $a, $b) = @ARGV;

open my $f, '<', $fname;
while (<$f>) {
    print if $a == $. .. $b == $.;
}
