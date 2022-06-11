#!/usr/bin/env raku

sub equilibrium-index(@arr) {
  my ($left, $right) = (0, [+] @arr);
  my $ret = -1;
  for @arr.kv -> $i, $val {
    $right -= $val;
    $ret = $i if $left == $right;
    $left += $val;
  }
  return $ret;
}

sub MAIN()
{
    my @arr = 1, 3, 5, 7, 9;
    put equilibrium-index(@arr);
    @arr = 1, 2, 3, 4, 5;
    put equilibrium-index(@arr);
    @arr = 2,4,2;
    put equilibrium-index(@arr);
}
