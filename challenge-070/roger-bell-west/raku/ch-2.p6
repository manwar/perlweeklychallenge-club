#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(gray(4),
          [0, 1, 3, 2, 6, 7, 5, 4, 12, 13, 15, 14, 10, 11, 9, 8],
          'example 1',
            );

sub gray ($depth) {
  my @s=(0,1);
  if ($depth>1) {
    my $k=1;
    for (2..$depth) {
      $k*=2;
      my @o=@s;
      map {push @o, $_ +| $k}, reverse @s.flat;
      @s=@o;
    }
  }
  return @s;
}
