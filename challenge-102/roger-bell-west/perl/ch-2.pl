#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 5;

is(hcs(1),'#','example 1');
is(hcs(2),'2#','example 2');
is(hcs(3),'#3#','example 3');
is(hcs(10),'#3#5#7#10#','example 4');
is(hcs(14),'2#4#6#8#11#14#','example 5');

use List::Util qw(sum);

sub hcs {
  my $n=shift;
  my @s;
  my @t;
  while (1) {
    @s=();
    my $l=0;
    if (@t) {
      @s=@{pop @t};
      $l=sum(map {($_==1?0:length($_))+1} @s);
    }
    if ($l==$n) {
      last;
    }
    if ($l > $n) {
      next;
    }
    my $c=$l;
    while (1) {
      my $tt=($c==1?0:length($c))+$l+1;
      if ($c==$tt) {
        push @t,[@s,$c];
      }
      if ($c > $tt) {
        last;
      }
      $c++;
    }
  }
  return join('',map {($_==1?'':$_).'#'} @s);
}
