#! /usr/bin/perl6

use Test;
plan 8;

my $ms=ms(3,1,1);

{
  is(sum(@($ms[0])),15,'row 1');
  is(sum(@($ms[1])),15,'row 2');
  is(sum(@($ms[2])),15,'row 3');
  is(sum(map {$ms[$_][0]}, (0..$ms.end)),15,'col 1');
  is(sum(map {$ms[$_][1]}, (0..$ms.end)),15,'col 2');
  is(sum(map {$ms[$_][2]}, (0..$ms.end)),15,'col 3');
  is(sum(map {$ms[$_][$_]}, (0..$ms.end)),15,'dia 1');
  is(sum(map {$ms[$_][2-$_]}, (0..$ms.end)),15,'dia 2');
}

sub ms($order,$start,$inc) {
  my $m=Array.new;
  for (1..$order) {
    push @($m),(0 xx $order).Array;
  }
  my ($x,$y)=(floor($order/2)+1,floor($order/2));
  my $n=$start;
  while (1) {
    $m[$x][$y]=$n;
    $n+=$inc;
    my ($xa,$ya)=(($x+1) % $order,($y+1) % $order);
    if ($m[$xa][$ya]>0) {
      ($xa,$ya)=(($x+2) % $order,$y);
      if ($m[$xa][$ya]>0) {
        last;
      }
    }
    ($x,$y)=($xa,$ya);
  }
  return $m;
}
