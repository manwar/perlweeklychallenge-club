#! /usr/bin/perl

use strict;
use warnings;

my @list=(1..50);
my $n=0;

while (scalar @list > 1) {
  $n++;
  if ($n>$#list) {
    $n=0;
  }
  splice @list,$n,1;
}

print $list[0],"\n";
