#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is_deeply(longprime(5),[7, 17, 19, 23, 29],'example 1');

is_deeply(longprime(60),[7, 17, 19, 23, 29, 47, 59, 61, 97, 109, 113, 131, 149, 167, 179, 181, 193, 223, 229, 233, 257, 263, 269, 313, 337, 367, 379, 383, 389, 419, 433, 461, 487, 491, 499, 503, 509, 541, 571, 577, 593, 619, 647, 659, 701, 709, 727, 743, 811, 821, 823, 857, 863, 887, 937, 941, 953, 971, 977, 983],'example 2');

sub is_prime {
  my $n=shift;
  if ($n>2 && $n%2==0) {
    return 0;
  }
  if ($n>3 && $n%3==0) {
    return 0;
  }
  my $lim=sqrt($n);
  my $k6=0;
  while (1) {
    $k6+=6;
    foreach my $t ($k6-1,$k6+1) {
      if ($t<=$lim) {
        if ($n % $t == 0) {
          return 0;
        }
      } else {
        return 1;
      }
    }
  }
}

sub longprime {
  my $n=shift;
  my $nn=$n;
  my @o;
  my @ba=(7);
  my $k6=6;
  while ($nn) {
    unless (@ba) {
      $k6+=6;
      @ba=($k6+1,$k6-1);
    }
    my $b=pop @ba;
    if (is_prime($b)) {
      my $k=1;
      my $l=0;
        while (1) {
          $k*=10;
          $l++;
          $k %= $b;
          if ($k==1) {
            last;
          }
        }
      if ($l==$b-1) {
        push @o,$b;
        $nn--;
      }
    }
  }
  return \@o;
}
