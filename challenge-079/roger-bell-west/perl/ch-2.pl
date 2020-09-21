#! /usr/bin/perl

use strict;
use warnings;

use List::Util qw(min max);

use Test::More tests => 2;

is(capacity([2,1,4,1,2,5]),6,'example 1');
is(capacity([3,1,3,1,1,5]),6,'example 2');

histo([2,1,4,1,2,5]);
histo([3,1,3,1,1,5]);

sub capacity {
  my @n=@{shift @_};
  my $cap=0;
  foreach my $r (min(@n)..max(@n)) {
    my @b=grep {$n[$_]>=$r} (0..$#n);
    if (scalar @b > 1) {
      foreach my $i (0..$#b-1) {
        $cap += $b[$i+1]-$b[$i]-1;
      }
    }
  }
  return $cap;
}

sub histo {
  my @n=@{shift @_};
  my $mx=max(@n);
  my $cw=int(log($mx+1)/log(10)+.9999);
  for (my $r=$mx;$r>0;$r--) {
    my @row=(sprintf('%'.$cw.'d',$r));
    push @row,map {($n[$_]>=$r?'#' x $cw:' ' x $cw)} (0..$#n);
    print join(' ',@row),"\n";
  }
  print join(' ',('-' x $cw) x (1+scalar @n)),"\n";
  print join(' ',map {sprintf('%'.$cw.'s',$_)} ('',@n)),"\n";
}
