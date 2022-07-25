#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(perfecttotient(20),
          [ 3, 9, 15, 27, 39, 81, 111, 183, 243, 255, 327, 363, 471,
            729, 2187, 2199, 3063, 4359, 4375, 5571 ],
          'example 1');

sub eulertotient($n) {
    my $et = 0;
    for 1..$n -> $k {
        if ($n gcd $k == 1) {
            $et++;
        }
    }
    return $et;
}

sub iteratedtotient($n0) {
  my $p = 0;
  my $n = $n0;
  while (True) {
    $n = eulertotient($n);
    $p += $n;
    if ($n == 1) {
      last;
    }
    if ($p > $n0) {
      last;
    }
  }
  return $p;
}

sub perfecttotient($ct) {
  my @o;
  my $n = 1;
  while (@o.elems < $ct) {
    $n++;
    if (iteratedtotient($n) == $n) {
      @o.push($n);
    }
  }
  return @o;
}
