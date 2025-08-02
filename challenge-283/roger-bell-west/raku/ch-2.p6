#! /usr/bin/raku

use Test;

plan 2;

is(digitcountvalue([1, 2, 1, 0]), True, 'example 1');
is(digitcountvalue([0, 3, 0]), False, 'example 2');

sub digitcountvalue(@a) {
  my %c;
  @a.map({%c{$_}++});
  for 0 .. @a.end -> $ix {
    if (@a[$ix] != (%c{$ix} || 0)) {
      return False;
    }
  }
  return True;
}
