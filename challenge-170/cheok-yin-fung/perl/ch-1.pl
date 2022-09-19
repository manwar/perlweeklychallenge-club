#!/usr/bin/perl
# The Weekly Challenge 170
# Task 1 Primorial Numbers

use v5.24.0;
use warnings;

my @prime = (2, 3, 5, 7, 11, 13, 17, 19, 23);

say my $x = 1;

say $x*=$prime[$_] for 0..8;

