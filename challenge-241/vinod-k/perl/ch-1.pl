#!/usr/bin/perl
use strict;
use warnings;

my @a = (4, 5, 6, 7, 8, 9);
my %params = map { $_ => 1 } @a;

my $diff = 2;
my $count = 0;

foreach my $i (@a){
  if(exists($params{$i + $diff}) && exists($params{$i+$diff+$diff})){
    $count++;
  }
}

print "Unique Arithmetic Triplets with diff $diff: $count\n";
