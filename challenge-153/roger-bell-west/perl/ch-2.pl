#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(factorion(145),1,'example 1');

is(factorion(125),0,'example 2');

sub factorion {
  my $input = shift;
  if ($input==0) {
    return 0;
  }
  my @fd=(1);
  my $ff=1;
  foreach my $i (1..9) {
    $ff *= $i;
    push @fd,$ff;
  }
  my $working=$input;
  my $dsum=0;
  while ($working > 0) {
    $dsum += $fd[$working%10];
    $working=int($working/10);
  }
  return ($input==$dsum)?1:0;
}
