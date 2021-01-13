#! /usr/bin/perl

use strict;
use warnings;

my @l=(-25,-10,-7,-3,2,4,8,10);
my $t=0;

@l=sort {$a <=> $b} @l;
my %r;
foreach my $a (0..$#l-2) {
  foreach my $b ($a+1..$#l-1) {
    foreach my $c ($b+1..$#l) {
      if ($l[$a]+$l[$b]+$l[$c]==$t) {
        $r{$l[$a]}{$l[$b]}{$l[$c]}=1;
      }
    }
  }
}

foreach my $d (sort {$a <=> $b} keys %r) {
  foreach my $e (sort {$a <=> $b} keys %{$r{$d}}) {
    foreach my $f (sort {$a <=> $b} keys %{$r{$d}{$e}}) {
      print "$d + $e + $f\n";
    }
  }
}
