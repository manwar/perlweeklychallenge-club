#! /usr/bin/perl6

use Test;

plan 2;

is(r2qi(4),"10300",'example 1');

is(qi2r("10300"),4,'example 2');

sub r2qi($n) {
  return c2qi($n, 0);
}

sub c2qi($r0, $i0) {
  my @l;
  for ($i0, $r0) -> $n0 {
    my $n = $n0;
    my @digits;
    while ($n != 0) {
      my $digit = $n % -4;
      $n = floor($n/-4);
      if ($digit < 0) {
        $digit += 4;
        $n += 1;
      }
      @digits.push($digit);
    }
    @l.push(@digits);
  }
  my $ld = @l[0].elems - @l[1].elems;
  if ($ld < 0) {
    @l[0].unshift((0 xx (-$ld-1)).Slip);
  } elsif ($ld > 1) {
    @l[1].unshift((0 xx $ld).Slip);
  }
  my $o = '';
  for (0..@l[1].end).reverse -> $i {
    for (0,1) -> $b {
      if (@l[$b].elems > $i) {
          $o ~= @l[$b][$i];
      }
    }
  }
  return $o;
}

sub qi2r($n) {
  return qi2c($n)[0];
}

sub qi2c($n) {
  my $pow = 1;
  my $ri = 0;
  my @o = (0) xx 2;
  for $n.comb.reverse -> $ch {
    @o[$ri] += $ch * $pow;
    $ri++;
    $pow *= 2;
    if ($ri == 2) {
      $ri = 0;
      $pow = -$pow;
    }
  }
  return @o;
}
