#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(smith(10),
          [4, 22, 27, 58, 85, 94, 121, 166, 202, 265,],
          'example 1'
            );

sub smith($ccount) {
  my $count=$ccount;
  my @o;
  my $c=1;
  while (1) {
    $c++;
    my @ff=factor($c);
    if (@ff.elems == 1) {
      next;
    }
    if (sumofdigits(($c,))==sumofdigits(@ff)) {
      push @o,$c;
      $count--;
      if ($count <= 0) {
        last;
      }
    }
  }
  return @o;
}

sub factor($nn) {
  my $n=$nn;
  my @f;
  my $ft=2;
  while ($n > 1) {
    if ($n % $ft == 0) {
      push @f,$ft;
      $n /= $ft;
    } else {
      $ft++;
      if ($ft % 2 == 0) {
        $ft++;
      }
    }
  }
  return @f;
}

sub sumofdigits(@l) {
  my $s=0;
  for @l -> $k {
    my $l=$k+0;
    while ($l > 0) {
      $s+=$l % 10;
      $l=floor($l/10);
    }
  }
  return $s;
}
