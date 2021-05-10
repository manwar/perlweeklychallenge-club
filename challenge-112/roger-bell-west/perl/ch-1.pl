#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 4;

is(cp('/a/'),'/a','example 1');
is(cp('/a/b//c/'),'/a/b/c','example 2');
is(cp('/a/b/c/../..'),'/a','example 3');
is(cp('/a/./b'),'/a/b','example 4');

sub cp {
  my $i=shift;
  my @p=grep {$_ ne '.'} grep /./,split /\//,$i;
  my $d=1;
  while ($d) {
    $d=0;
    foreach my $pi (1..$#p) {
      if ($p[$pi] eq '..') {
        splice @p,$pi-1,2;
        $d=1;
        last;
      }
    }
  }
  return '/'.join('/',@p);
}
