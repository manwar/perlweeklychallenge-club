#!/usr/bin/env perl
use warnings;
use strict;
use Memoize;

# Problem: Write a script to display first 20 Leonardo Numbers.

sub leonardo {
  my $i = shift;
  return 1 if $i <= 1;
  return leonardo($i-2)+leonardo($i-1)+1;
}
memoize('leonardo');

foreach my $i (0..20){
  print leonardo($i)."\n";
}
