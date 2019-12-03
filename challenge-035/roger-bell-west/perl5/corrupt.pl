#! /usr/bin/perl

use strict;
use warnings;

while (<>) {
  chomp;
  my $t=$_;
  foreach (0..int(rand()*length($t)/2)) {
    substr($t,
           int(rand()*length($t)),
           1,
           (rand()<0.5)?'0':'1');
  }
  print "$t\n";
}
