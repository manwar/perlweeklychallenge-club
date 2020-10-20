#! /usr/bin/perl

use strict;
use warnings;
use integer;

use List::Util qw(sum);

use Test::More tests => 3;

is (fa(3,10,8),1,'example 1');
is (fa(12,2,10),1,'example 2');
is (fa(2,2,10),2,'example 3');

sub fa {
  my @a=@_;
  my $n = (1 << scalar @a);
  my $ss=sum(@a);
  my $ls;
  my $li;
  foreach my $mask (1..$n-1) {
    my $s=$ss;
    my $m=1;
    my $inv=0;
    foreach my $i (0..$#a) {
      if ($m & $mask) {
        $inv++;
        $s -= 2*$a[$i];
      }
      $m <<= 1;
    }
    if ($s>=0 && (!defined $ls || $s < $ls || ($ls == $s && $inv < $li))) {
      $ls=$s;
      $li=$inv;
    }
  }
  return $li;
}
