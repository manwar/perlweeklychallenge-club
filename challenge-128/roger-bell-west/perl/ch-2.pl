#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(mp([qw(11:20 14:30)],
      [qw(11:50 15:00)]),
          1,'example 1');
is(mp([qw(10:20 11:00 11:10 12:20 16:20 19:00)],
      [qw(10:30 13:20 12:40 12:50 20:20 21:20)]),
          3,'example 2');

sub mp {
  my ($aa,$da)=@_;
  my %e;
  foreach my $p ([$aa,1],[$da,-1]) {
    foreach my $tm (@{$p->[0]}) {
      if ($tm =~ /([0-9]+):([0-9]+)/) {
        $e{$1*60+$2}+=$p->[1];
      }
    }
  }
  my $pt=0;
  my $pm=0;
  foreach my $ts (sort {$a <=> $b} keys %e) {
    $pt+=$e{$ts};
    if ($pt > $pm) {
      $pm=$pt;
    }
  }
  return $pm;
}
