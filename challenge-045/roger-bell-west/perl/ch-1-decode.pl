#! /usr/bin/perl

use strict;
use warnings;

my @in;
while (<>) {
  chomp;
  push @in,split ' ',$_;
}

my @out;
foreach my $n (0..length($in[0])-1) {
  foreach my $w (@in) {
    if (length($w)<$n+1) {
      last;
    }
    push @out,substr($w,$n,1);
  }
}

print join('',@out),"\n";
