#! /usr/bin/perl6

use Test;

plan 2;

is(npn(1234),1331,'example 1');
is(npn(999),1001,'example 2');

sub npn($n) {
  my ($i,$m);
  my $l=chars($n);
  if ($l % 2 == 0) {
    $i=substr($n,0,$l/2);
    $m=1;
  } else {
    $i=substr($n,0,($l+1)/2);
    $m=0;
  }
  $i--;
  my $pn=0;
  while ($pn <= $n) {
    my $f=chars($i);
    $i++;
    if (chars($i) > $f) {
      if ($m==0) {
        $m=1;
        $i=10**($f-1);
      } else {
        $m=0;
        $i=10**$f;
      }
    }
    my $k=$i.flip;
    if ($m==0) {
      $pn=$i ~ substr($k,1);
    } else {
      $pn=$i ~ $k;
    }
  }
  return $pn;
}
