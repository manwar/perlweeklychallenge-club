#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is_deeply(bt2ll([1,2,3,4,5,undef,undef,undef,undef,6,7]),
          [1,2,4,5,6,7,3],
          'example 1',
            );

sub bt2ll {
  my $tree=shift;
  return recurse($tree,0,[]);
}

sub recurse {
  my ($tree,$start,$out)=@_;
  push @{$out},$tree->[$start];
  my $b=$start*2+1;
  foreach my $ba ($b,$b+1) {
    if ($ba <= $#{$tree} && defined $tree->[$ba]) {
      recurse($tree,$ba,$out);
    }
  }
  return $out;
}
