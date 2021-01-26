#!/usr/bin/perl

# Challenge 020
#
# Task #1
# Write a script to accept a string from command line and split it on change
# of character. For example, if the string is “ABBCDEEF”, then it should split
# like “A”, “BB”, “C”, “D”, “EE”, “F”.

use strict;
use warnings;
use 5.030;

my $str = shift;

my @segs;
while ($str ne '') {
    $str =~ s/^((.)\2*)//x or die;
    push @segs, $1;
}

say join(", ", map {'"'.$_.'"'} @segs), ".";
