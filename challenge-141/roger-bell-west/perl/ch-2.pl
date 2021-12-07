#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(likenumber(1234,2),9,'example 1');
is(likenumber(768,4),3,'example 2');

sub likenumber {
  my ($source,$factor)=@_;
  my @s=split '',$source;
  my $m=scalar @s;
  my $n=0;
  foreach my $mask (1..(1<<$m)-2) {
    my $c=0;
    foreach my $di (0..$m-1) {
      if ($mask & 1<<$di) {
        $c=$c*10+$s[$di];
      }
    }
    if ($c % $factor == 0) {
      $n++;
    }
  }
  return $n;
}
