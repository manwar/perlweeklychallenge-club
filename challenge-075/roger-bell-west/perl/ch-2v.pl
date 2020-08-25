#! /usr/bin/perl

use strict;
use warnings;
use List::Util qw(min max);

lrhist(2,1,4,5,3,7);

lrhist(3,2,3,5,7,5);

sub lrhist {
  my @c=@_;
  my $bestarea=0;
  my @n=(0,0);
  foreach my $a (0..$#c-1) {
    foreach my $b ($a+1..$#c) {
      my $area=($b-$a+1)*min(@c[$a..$b]);
      if ($area>$bestarea) {
        $bestarea=$area;
        @n=($a,$b);
      }
    }
  }
  my $mx=max(@c);
  my $cw=int(log($mx+1)/log(10)+.9999);
  for (my $r=$mx;$r>0;$r--) {
    my @row=(sprintf('%'.$cw.'d',$r));
    push @row,map {($c[$_]>=$r?'#' x $cw:' ' x $cw)} (0..$#c);
    print join(' ',@row),"\n";
  }
  print join(' ',('-' x $cw) x (1+scalar @c)),"\n";
  print join(' ',map {sprintf('%'.$cw.'s',$_)} ('',@c)),"\n";
}
