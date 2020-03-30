#! /usr/bin/perl6

while (my $n=shift @*ARGS) {
  my @k=($n);
  while ($n != 1) {
    if ($n % 2 == 0) {
      $n/=2;
    } else {
      $n*=3;
      $n++;
    }
    push @k,$n;
  }
  say join(', ',@k);
}
