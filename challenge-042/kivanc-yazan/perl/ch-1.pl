#!/usr/bin/env perl
use warnings;
use strict;

# Write a script to print decimal number 0 to 50 in Octal Number System.
for my $i (0..50){
  printf "Decimal %d = Octal %o\n", $i, $i;
}
