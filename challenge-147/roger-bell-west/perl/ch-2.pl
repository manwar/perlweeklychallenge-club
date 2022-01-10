#! /usr/bin/perl

use strict;
use warnings;

pentpair();

sub pentpair {
  my @fpent=(0);
  my %rpent;
  my $mx=0;
  my $a=1;
  while (1) {
    while ($mx < $a) {
      $mx++;
      push @fpent,pentagon($mx);
      $rpent{$fpent[$mx]}=$mx;
    }
    foreach my $b (1..$a-1) {
      my $d=$fpent[$a]-$fpent[$b];
      if ($d < $fpent[$b]) {
        last;
      }
      if (exists $rpent{$d}) {
        my $s=$fpent[$a]+$fpent[$b];
        while ($s > $fpent[$mx]) {
          $mx++;
          push @fpent,pentagon($mx);
          $rpent{$fpent[$mx]}=$mx;
        }
        if (exists $rpent{$s}) {
          print "P($a) + P($b) = $fpent[$a] + $fpent[$b] = $s = P($rpent{$s})\n";
          print "P($a) - P($b) = $fpent[$a] - $fpent[$b] = $d = P($rpent{$d})\n";
          exit 0;
        }
      }
    }
    $a++;
  }
}

sub pentagon {
  my $n=shift;
  return $n*(3*$n-1)/2;
}
