#! /usr/bin/perl

use strict;

use Test::More tests => 1;

is_deeply(smith(10),[4, 22, 27, 58, 85, 94, 121, 166, 202, 265,],'example 1');

use integer;

sub smith {
  my $count=shift;
  my @o;
  my $c=1;
  while (1) {
    $c++;
    my @ff=factor($c);
    if (scalar @ff == 1) {
      next;
    }
    if (sumofdigits($c)==sumofdigits(@ff)) {
      push @o,$c;
      $count--;
      if ($count <= 0) {
        last;
      }
    }
  }
  return \@o;
}

sub factor {
  my $n=0+shift;
  my @f;
  my $ft=2;
  while ($n > 1) {
    if ($n % $ft == 0) {
      push @f,$ft;
      $n /= $ft;
    } else {
      $ft++;
      if ($ft % 2 == 0) {
        $ft++;
      }
    }
  }
  return @f;
}

sub sumofdigits {
  my $s=0;
  foreach my $k (@_) {
    my $l=$k+0;
    while ($l > 0) {
      $s+=$l % 10;
      $l /= 10;
    }
  }
  return $s;
}
