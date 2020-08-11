#! /usr/bin/perl

use strict;
use warnings;

my @place;
while (<>) {
  chomp;
  my @k=split / /,$_;
  map {$place[$_]{$k[$_]}++} (0..$#k);
}

foreach my $h (@place) {
  my @v=values %{$h};
  my @k=keys %{$h};
  my @i=sort {$v[$b] <=> $v[$a]} (0..$#v);
  print $k[$i[0]];
}
print "\n";
