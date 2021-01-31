#!/usr/bin/perl

use strict;
use warnings;
use List::MoreUtils qw(first_index);

# Input
my $S = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG";
my $N = 3;

# Caesar Cipher
my @plain = ("A"..."Z");
my @cipher = ("A"..."Z");
push @cipher, splice @cipher, 0, (26 - $N);

foreach my $c (split //, $S) {
  if($c eq " ") {
    print $c;
  } else {
    my $i = first_index { $_ eq $c } @plain;
    print $cipher[$i];
  }
}
