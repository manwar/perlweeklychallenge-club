#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

use List::Util qw(sum);

is(is_weird(12),
          0,
          'example 1');

is(is_weird(13),
          0,
          'example 2');

is(is_weird(70),
          1,
          'example 3');

sub divisors {
  my $n=shift;
  my @ff=(1);
  if ($n==1) {
    return \@ff;
  }
  my $s=int(sqrt($n));
  if ($s * $s == $n) {
    push @ff,$s;
    $s--;
  }
  foreach my $pf (2..$s) {
    if ($n % $pf == 0) {
      push @ff,$pf;
      push @ff,int($n/$pf);
    }
  }
  return \@ff;
}

sub is_weird {
  my $n=shift;
  my @dd=@{divisors($n)};
  if (sum(@dd) <= $n) {
    return 0;
  }
  foreach my $mask (1..(1 << scalar @dd)-1) {
    my $ss=0;
    foreach my $i (0..$#dd) {
      if ($mask & (1 << $i)) {
        $ss += $dd[$i];
        if ($ss > $n) {
          last;
        }
      }
      if ($ss == $n) {
        return 0;
      }
    }
  }
  return 1;
}
