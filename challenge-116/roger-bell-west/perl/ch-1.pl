#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 5;

is_deeply(ns(1234),[1,2,3,4],'example 1');
is_deeply(ns(91011),[9,10,11],'example 2');
is_deeply(ns(10203),[10203],'example 3');
is_deeply(ns(910911),[910,911],'example 4');
is_deeply(ns(9109119),[9109119],'example 5');

sub ns {
  my $n=shift;
  my $l=length($n);
  foreach my $sl (1..int($l/2)) {
    my $i=$sl;
    my @e=(substr($n,0,$sl));
    while (1) {
      if ($l-$i == 0) {
        last;
      }
      push @e,$e[-1]+1;
      my $el=length($e[-1]);
      if ($l-$i < $el ||
            substr($n,$i,$el) ne $e[-1]) {
        @e=();
        last;
      }
      $i+=$el;
    }
    if (@e) {
      return \@e;
    }
  }
  return [$n];
}
