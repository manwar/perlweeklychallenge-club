#! /usr/bin/perl6

use Test;

plan 3;

is(ts(1.2, 0.4, 0.1, 2.5),1,'example 1');
is(ts(0.2, 1.5, 0.9, 1.1),0,'example 2');
is(ts(0.5, 1.1, 0.3, 0.7),1,'example 3');

sub ts(**@a) {
  my @n=grep {$_ < 2}, @a;
  for @a.combinations(3) -> @b {
    my $s=sum(@b);
    if ($s > 1 && $s < 2) {
      return 1;
    }
  }
  return 0;
}
