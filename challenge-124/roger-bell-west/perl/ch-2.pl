#! /usr/bin/perl

use strict;
use warnings;

use Algorithm::Combinatorics qw(combinations);
use List::Util qw(sum);

tow([10, 20, 30, 40, 50, 60, 70, 80, 90, 100]);
print "\n";

tow([10, -15, 20, 30, -25, 0, 5, 40, -5]);

sub tow {
  my $n=shift;
  my $target=int(sum(@{$n})/2);
  my $k=int((scalar @{$n})/2);
  my $bestval=-1;
  my $bestset;
  foreach my $set (combinations($n,$k)) {
    my $l=abs($target-sum(@{$set}));
    if ($bestval<0 || $l < $bestval) {
      $bestval=$l;
      $bestset=[@{$set}];
    }
  }
  my @o=([],[]);
  my %r=map {$_ => 1} @{$bestset};
  foreach my $m (@{$n}) {
    if (exists $r{$m}) {
      push @{$o[1]},$m;
    } else {
      push @{$o[0]},$m;
    }
  }
  foreach my $i (0,1) {
    print "(",join(', ',@{$o[$i]}),")\n";
  }
}
