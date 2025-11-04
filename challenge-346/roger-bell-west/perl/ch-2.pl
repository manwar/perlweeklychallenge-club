#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(magicexpression('123', 6), ['1*2*3', '1+2+3'], 'example 1');
is_deeply(magicexpression('105', 5), ['1*0+5', '10-5'], 'example 2');
is_deeply(magicexpression('232', 8), ['2*3+2', '2+3*2'], 'example 3');
is_deeply(magicexpression('1234', 10), ['1*2*3+4', '1+2+3+4'], 'example 4');
is_deeply(magicexpression('1001', 2), ['1+0*0+1', '1+0+0+1', '1+0-0+1', '1-0*0+1', '1-0+0+1', '1-0-0+1'], 'example 5');

sub magicexpression($number, $target) {
  my @n = split '', $number;
  my $l = length($number) - 1;
  my @counter = (0) x $l;
  my @out;
 LOOP:
  while (1) {
    my $i = 0;
    $counter[$i]++;
    while ($counter[$i] == 4) {
      $counter[$i] = 0;
      $i++;
      if ($i < $l) {
        $counter[$i]++;
      } else {
        last LOOP;
      }
    }
    my $ex = '';
    foreach my $i (0 .. $l - 1) {
      $ex .= $n[$i];
      $ex .= ['', '+', '-', '*']->[$counter[$i]];
    }
    $ex .= $n[$l];
    if ($ex =~ /(^|\D)0\d/) {
      next LOOP;
    }
    if (eval($ex) == $target) {
      push @out, $ex;
    }
  }
  @out = sort @out;
  \@out;
}
