#! /usr/bin/raku

use Test;

plan 3;

is(lastmember([2, 7, 4, 1, 8, 1]), 1, 'example 1');
is(lastmember([1]), 1, 'example 2');
is(lastmember([1, 1]), 0, 'example 3');

sub lastmember(@a0) {
  my @a = @a0;
  while (@a.elems > 1) {
    @a = @a.sort( {.Int} );
    my $x = @a.pop();
    my $y = @a.pop;
    if ($x != $y) {
      @a.push($x - $y);
    }
  }
  if (@a.elems == 0) {
    return 0;
  } else {
    return @a[0];
  }
}
