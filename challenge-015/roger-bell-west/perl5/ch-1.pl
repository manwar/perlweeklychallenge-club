#! /usr/bin/perl

use strict;
use warnings;

# Arbitrary cap
my $cap=110;

my $limit=10;

# Sieve of Eratosthenes to give us a prime list
my %n=map {$_ => 1} (2..$cap);
foreach my $f (2..int(sqrt($cap))) {
  map {($f<$_ && $_%$f == 0)?delete $n{$_}:0} keys %n;
}
my @p=sort {$a <=> $b} (keys %n);

# Double difference finds the ones closer to prime above than to prime below
my @d1=map {$p[$_+1]-$p[$_]} (0..$#p-1);
my @d2=map {$d1[$_+1]-$d1[$_]} (0..$#d1-1);

my @res;
foreach my $k (0..$#d2) {
  my $i=1;
  if ($d2[$k]<0) {
    $i=0;
  }
  push @{$res[$i]},$p[$k+1];
}

my @l=qw(Strong Weak);
if (scalar @{$res[0]} >= $limit && scalar @{$res[1]} >= $limit) {
  foreach my $m (0,1) {
    splice @{$res[$m]},$limit;
    print $l[$m],': ',join(', ',@{$res[$m]}),"\n";
  }
} else {
  warn "Re-run with a higher cap value\n";
}
