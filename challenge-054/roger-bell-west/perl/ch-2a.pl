#! /usr/bin/perl

use strict;
use warnings;

use integer;

my %l;
my %s;

$l{1}=1;

foreach my $n (1..1e6) {
  my $k=1;
  my $na=$n;
  while (!exists $l{$na}) {
    if ($na % 2 == 0) {
      $na/=2;
    } else {
      $na*=3;
      $na++;
    }
    $k++;
  }
  $l{$n}=$k+$l{$na};
  push @{$s{$l{$n}}},$n;
}

my $k=20;
foreach my $c (sort {$b <=> $a} keys %s) {
  print "$c: ".join(', ',sort @{$s{$c}}),"\n";
  $k-=scalar @{$s{$c}};
  if ($k<=0) {
    last;
  }
}
