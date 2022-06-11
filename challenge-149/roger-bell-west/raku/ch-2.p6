#! /usr/bin/perl6

use Test;

plan 4;

is(ls(2),'1','example 1');
is(ls(4),'3201','example 2');
is(ls(10),'9814072356','example 3');
is(ls(12),'B8750A649321','example 4');

sub ls($base) {
  my $max=0;
  loop (my $i=$base-1;$i >= 0; $i--) {
    $max *= $base;
    $max += $i;
  }
  my $t=floor(sqrt($max));
  my @digits=['0'..'9'];
  @digits.append('A'..'Z');
  while (1) {
    my $s=$t*$t;
    my $v=True;
    my @c=0 xx $base;
    my @dg;
    while ($s > 0) {
      my $d=$s % $base;
      @c[$d]++;
      if (@c[$d] > 1) {
        $v=False;
        last;
      }
      $s = floor($s/$base);
      unshift @dg,@digits[$d];
    }
    if ($v) {
      return join('',@dg);
    }
    $t--;
  }
}
