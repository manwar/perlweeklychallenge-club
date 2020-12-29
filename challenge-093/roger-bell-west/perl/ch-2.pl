#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(sp(1,2,undef,3,4),13,'example 1');
is(sp(1,2,3,4,undef,5,6),26,'example 2');

use List::Util qw(sum);

sub sp {
  my @t=@_;
  my $s=0;
  my @path=([0]);
  while (my $a=shift @path) {
    my $c=($a->[-1]+1)*2-1;
    my $tn=1;
    foreach my $ac ($c,$c+1) {
      if ($ac <= $#t && defined $t[$ac]) {
        push @path,[@{$a},$ac];
        $tn=0;
      }
    }
    if ($tn) {
      $s+=sum(map {$t[$_]} @{$a});
    }
  }
  return $s;
}
