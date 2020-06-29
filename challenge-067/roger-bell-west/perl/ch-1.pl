#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is_deeply(combine(5,2),
          [ [1,2], [1,3], [1,4], [1,5], [2,3], [2,4], [2,5], [3,4], [3,5], [4,5] ],
          'expansion 5 2',
            );
is_deeply(combine(4,3),
          [ [1,2,3], [1,2,4], [1,3,4], [2,3,4] ],
          'expansion 4 3',
            );

sub combine {
  my ($m,$n)=@_;
  my @out;
  my @a;
  do {
    my $s=[];
    if (@a) {
      $s=shift @a;
    }
    if (scalar @{$s} < $n) {
      my $base=0;
      if (@{$s}) {
        $base=$s->[-1];
      }
      foreach my $k ($base+1..$m) {
        push @a,[@{$s},$k];
      }
    } else {
      push @out,$s;
    }
  } while @a;
  return \@out;
}
