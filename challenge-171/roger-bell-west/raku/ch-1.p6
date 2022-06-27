#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(oddabundant(20),
          [945, 1575, 2205, 2835, 3465, 4095, 4725, 5355, 5775, 5985,
           6435, 6615, 6825, 7245, 7425, 7875, 8085, 8415, 8505,
           8925],
          'example 1');

sub abundant($n) {
    if ($n==1) {
        return False;
    }
    my $ff=1;
    my $s=floor(sqrt($n));
    if ($s * $s == $n) {
        $ff += $s;
        $s--;
    }
    for 2..$s -> $pf {
        if ($n % $pf == 0) {
            $ff += $pf;
            $ff += $n div $pf;
            if ($ff > $n) {
                return True;
            }
        }
    }
    return False;
}

sub oddabundant($ct) {
  my $n = 1;
  my @o;
  while (True) {
    if (abundant($n)) {
      @o.push($n);
      if (@o.elems >= $ct) {
        last;
      }
    }
    $n += 2;
  }
  return @o;
}
