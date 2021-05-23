#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(ri(25,7),0,'example 1');
is(ri(24,7),1,'example 2');

sub ri {
  my ($n,$d)=@_;
  my @e=grep /$d/,(1..$n);
  foreach my $i (1..(1<<(scalar @e))-1) {
    my $s=0;
    foreach my $ii (0..$#e) {
      if (1<<$ii & $i) {
        $s+=$e[$ii];
      }
    }
    if ($s==$n) {
      return 1;
    }
  }
  return 0;
}
