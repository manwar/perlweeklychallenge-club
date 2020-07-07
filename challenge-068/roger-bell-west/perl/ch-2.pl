#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is_deeply(rl([1,2,3,4]),
          [1,4,2,3],
          'example 1',
            );
is_deeply(rl([1,2,3,4,5]),
          [1,5,2,4,3],
          'example 2',
            );

sub rl {
  my $list=shift;
  my $n=scalar @{$list};
  my $nx=$n-1;
  my @i;
  foreach my $ni (0..int($nx/2)) {
    push @i,$ni,$nx-$ni;
  }
  if ($i[-1] == $i[-2]) {
    pop @i;
  }
  @{$list}=@{$list}[@i];
  return $list;
}
