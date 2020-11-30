#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 8;

use List::Util qw(sum);

my $ms=ms(3,1,1);

{
  is(sum(@{$ms->[0]}),15,'row 1');
  is(sum(@{$ms->[1]}),15,'row 2');
  is(sum(@{$ms->[2]}),15,'row 3');
  is(sum(map {$ms->[$_][0]} (0..$#{$ms})),15,'col 1');
  is(sum(map {$ms->[$_][1]} (0..$#{$ms})),15,'col 2');
  is(sum(map {$ms->[$_][2]} (0..$#{$ms})),15,'col 3');
  is(sum(map {$ms->[$_][$_]} (0..$#{$ms})),15,'dia 1');
  is(sum(map {$ms->[$_][2-$_]} (0..$#{$ms})),15,'dia 2');
}

print tabular($ms);

sub ms {
  my ($order,$start,$inc)=@_;
  my $m;
  foreach (1..$order) {
    push @{$m},[(0) x $order];
  }
  my ($x,$y)=(int($order/2)+1,int($order/2));
  my $n=$start;
  while (1) {
    $m->[$x][$y]=$n;
    $n+=$inc;
    my ($xa,$ya)=(($x+1) % $order,($y+1) % $order);
    if ($m->[$xa][$ya]>0) {
      ($xa,$ya)=(($x+2) % $order,$y);
      if ($m->[$xa][$ya]>0) {
        last;
      }
    }
    ($x,$y)=($xa,$ya);
  }
  return $m;
}

sub tabular {
  my $d=shift;
  my @columnlength;
  foreach my $row (@{$d}) {
    foreach my $colno (0..$#{$row}) {
      if (!defined($columnlength[$colno]) ||
          $columnlength[$colno] < length($row->[$colno])) {
        $columnlength[$colno]=length($row->[$colno]);
      }
    }
  }
  my $format=join('  ',map {"%${_}s"} @columnlength);
  my $result='';
  foreach my $row (@{$d}) {
    $result .= sprintf($format,@{$row})."\n";
  }
  return $result;
}
