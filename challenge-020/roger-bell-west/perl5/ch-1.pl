#! /usr/bin/perl

use strict;
use warnings;

use List::Util qw(pairmap);

foreach my $in (@ARGV) {
  print join(' ',splitchange($in)),"\n";
}

sub splitchange {
  return pairmap {$a.$b} shift =~ /(.)(\g1*)/g;
}
