#! /usr/bin/perl

use strict;
use warnings;

foreach my $program (@ARGV) {
  my $n=1;
  if ($program =~ /ch-2/) {
    $n=2;
  }
  my $r=system("$program <input.ch$n.txt >test.ch$n.txt");
  if ($r != 0) {
    warn "$program failed\n";
    next;
  }
  my @l;
  foreach my $file ("output.ch$n.txt","test.ch$n.txt") {
    push @l,[];
    open I,'<',$file;
    while (<I>) {
      push @{$l[-1]},$_;
    }
  }
  my $ok=1;
  foreach my $ln(0..$#{$l[0]}) {
    if (!defined $l[1][$ln] || $l[1][$ln] ne $l[0][$ln]) {
      warn "$program failed to match at line $ln:\n$l[0][$ln]\n$l[1][$ln]\n";
      $ok=0;
    }
  }
  if ($ok) {
    warn "$program OK\n";
  }
  unlink("test.ch$n.txt");
}
