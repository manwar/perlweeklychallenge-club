#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(kronecker([[1,2],[3,4]],
                    [[5,6],[7,8]]),
          [
            [ 5,  6, 10, 12],
            [ 7,  8, 14, 16],
            [15, 18, 20, 24],
            [21, 24, 28, 32]
              ],
          'example 1');

sub kronecker(@a,@b) {
  my @o;
  my $ax = @a[0].elems;
  my $ay = @a.elems;
  my $bx = @b[0].elems;
  my $by = @b.elems;
  for (0..$ay*$by-1) -> $y {
    my $byi = $y % $by;
    my $ayi = $y div $by;
    my @row;
    for (0..$ax*$bx-1) -> $x {
      my $bxi = $x % $bx;
      my $axi = $x div $bx;
      push @row,@a[$ayi][$axi] * @b[$byi][$bxi];
  }
  push @o,@row;
  }
  return @o;
}
