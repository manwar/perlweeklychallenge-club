#! /usr/bin/perl

use strict;
use warnings;

use List::Util qw(min max product);

use Test::More tests => 3;

is(singlefactor(9),'3^2','nine');
is(singlefactor(45),'0','forty-five');
is(singlefactor(36),'6^2','thirty-six');

sub singlefactor {
  my $in=shift;
  my $factor=2;
  my %pf;
  while (1) {
    my $p=0;
    while ($in % $factor == 0) {
      $in/=$factor;
      $p++;
    }
    if ($p>0) {
      $pf{$factor}=$p;
    }
    if ($in < 2) {
      last;
    }
    if ($factor==2) {
      $factor++;
    } else {
      $factor+=2;
    }
  }
  if (max(values %pf) == min(values %pf)) {
    return product(keys %pf) . '^' . min(values %pf);
  } else {
    return '0';
  }
}
