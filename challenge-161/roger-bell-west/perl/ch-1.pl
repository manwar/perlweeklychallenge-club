#! /usr/bin/perl

use strict;
use warnings;

my @b;

while (<>) {
  chomp;
  my @a=split '',$_;
  my $u=1;
  foreach my $i (0..$#a-1) {
    if ($a[$i] gt $a[$i+1]) {
      $u=0;
      last;
    }
  }
  if ($u) {
    push @b,$_;
  }
}

print map {"$_\n"} sort {length($b) <=> length($a)} @b;
