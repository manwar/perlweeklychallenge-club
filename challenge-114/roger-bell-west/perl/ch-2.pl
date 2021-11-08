#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(hisb(3),5,'example 1');
is(hisb(12),17,'example 2');

sub hisb {
  my $n=shift;
  my $s='0'.sprintf('%b',$n);
  $s =~ /^(.*?)01(1*0*)$/;
  my ($a,$c)=($1,$2);
  (my $t0=$c) =~ s/1+//g;
  (my $t1=$c) =~ s/0+//g;
  return oct('0b' . $a . '10' . $t0 . $t1);
}
