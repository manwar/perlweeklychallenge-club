#!/usr/bin/env perl

# Write a script to accept a string from command line and split it on change of
# character. For example, if the string is “ABBCDEEF”, then it should split like
# “A”, “BB”, “C”, “D”, “EE”, “F”.

use 5.026;
use strict;
use warnings;

my $string = shift or die "Usage: $0 STRING\n";

say $& while $string =~ /(.)\g1*/g;
