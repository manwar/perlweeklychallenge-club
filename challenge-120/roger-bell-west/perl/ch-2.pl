#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(ca('03:10'),35,'example 1');
is(ca('04:00'),120,'example 2');

sub ca {
  my $n=shift;
  my $a=0;
  if ($n =~ /([0-9]+):([0-9]+)/) {
    my ($ha,$ma)=map {$_ % 360} ($1*30+$2/2,$2*6);
    $a=abs($ha-$ma);
    while ($a > 180) {
      $a-=360;
    }
    $a=abs($a);
  }
  return $a;
}
