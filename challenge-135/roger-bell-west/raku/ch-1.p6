#! /usr/bin/perl6

use Test;

plan 4;

is(m3d(1234567),'345','example 1');
is(m3d(-123),'123','example 2');
is(m3d(1),'too short','example 3');
is(m3d(1010),'even number of digits','example 4');

sub m3d($n) {
  my $m=abs($n);
  $m="$m";
  my $l=$m.chars();
  if ($l < 3) {
    return 'too short';
  }
  if ($l % 2 == 0) {
    return 'even number of digits';
  }
  return substr($m,floor($l/2)-1,3);
}
