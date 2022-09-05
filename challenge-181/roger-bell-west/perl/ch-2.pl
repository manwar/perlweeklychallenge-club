#! /usr/bin/perl

use strict;
use warnings;

my %t;

open my $fh,'<','temperature.txt';
while (<$fh>) {
  chomp;
  my @l = split(/\,\s*/,$_);
  $t{$l[0]} = $l[1];
}

my $lt = 999;
foreach my $k (sort keys %t) {
  if ($t{$k} > $lt) {
    print "$k\n";
  }
  $lt = $t{$k};
}
