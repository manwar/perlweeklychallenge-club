#! /usr/bin/perl

use strict;
use warnings;

# Arbitrary cap
my $cap=110;

my $limit=6;

# Sieve of Eratosthenes to give us a prime list
my %n=map {$_ => 1} (2..$cap);
foreach my $f (2..int(sqrt($cap))) {
  map {($f<$_ && $_%$f == 0)?delete $n{$_}:0} keys %n;
}
my @p=sort {$a <=> $b} (keys %n);
my %p=map {$_ => 1} @p;

foreach my $p (@p) {
  my $q=$p+6;
  if (exists $p{$q}) {
    print "$p, $q\n";
    $limit--;
    unless ($limit) {
      last;
    }
  }
}
