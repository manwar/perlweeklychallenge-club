#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is(fibstr("1234","5678",51),'7','example 1');

sub fibstr {
  my ($aa,$bb,$limit) = @_;
  my $a=$aa;
  my $b=$bb;
  while (1) {
    my $c=$a.$b;
    print "$c\n";
    if (length($c) >= $limit) {
      return substr($c,$limit-1,1);
    }
    ($a,$b)=($b,$c);
  }
}
