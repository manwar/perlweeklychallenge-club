#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(chowla(20),[0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21],'example 1');

sub chowla($count) {
  my @a;
  for 1..$count -> $n {
    push @a,sum(gather {
      take 0;
      for (2..floor($n/2)) {
        take $_ if $n %% $_
      }
    });
  }
  return @a;
}
