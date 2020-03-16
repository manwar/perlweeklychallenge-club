#! /usr/bin/perl

use strict;
use warnings;

my @a=@ARGV;

if ($a[0]>$a[1]) {
  @a=($a[1],$a[0]);
}

foreach my $c ($a[0]..$a[1]) {
  my @d=split '',$c;
  my $v=1;
  foreach my $i (0..$#d-1) {
    if ($d[$i]+1 != $d[$i+1]) {
      $v=0;
      last;
    }
  }
  if ($v) {
    print "$c\n";
  }
}
