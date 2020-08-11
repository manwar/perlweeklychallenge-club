#! /usr/bin/perl

use strict;
use warnings;

use Math::BigInt lib => 'GMP';

foreach my $i (@ARGV) {
  my $f=primefactor(Math::BigInt->new($i));
  my @o="$i:";
  foreach my $ff (sort {$a <=> $b} keys %{$f}) {
    push @o,($ff) x $f->{$ff};
  }
  print join(' ',@o),"\n";
}

sub primefactor {
  my $n=shift;
  my %out;
  while ($n%2 == 0) {
    $out{2}++;
    $n/=2;
  }
  my $k=Math::BigInt->new(3);
  while ($k*$k <= $n) {
    while ($n % $k == 0) {
      $out{$k}++;
      $n /= $k;
    }
    $k+=2;
  }
  $out{$n}++;
  return \%out;
}
