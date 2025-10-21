#! /usr/bin/raku

use Test;

plan 5;

is(zerofriend([4, 2, -1, 3, -2]), -1, 'example 1');
is(zerofriend([-5, 5, -3, 3, -1, 1]), 1, 'example 2');
is(zerofriend([7, -3, 0, 2, -8]), 0, 'example 3');
is(zerofriend([-2, -5, -1, -8]), -1, 'example 4');
is(zerofriend([-2, 2, -4, 4, -1, 1]), 1, 'example 5');

sub zerofriend(@a) {
  my $b = @a.map({$_.abs}).min;
  my %ah = @a.map({$_ => 1});
  if (%ah{$b}:exists) {
    return $b;
  }
  -$b;
}
