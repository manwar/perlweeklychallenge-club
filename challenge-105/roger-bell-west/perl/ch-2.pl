#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(ng('Katie'),"Katie, Katie, bo-batie\nBonana-fanna fo-fatie\nFee fi mo-matie\nKatie!",'example 1');
is(ng('Anna'),"Anna, Anna, bo-banna\nBonana-fanna fo-fanna\nFee fi mo-manna\nAnna!",'example 2');

sub ng {
  my $name=shift;
  (my $tail=$name) =~ s/^[bcdfghjklmnpqrstvwxz]*//i;
  if ($tail eq $name) {
    $tail=lc($tail);
  }
  return "$name, $name, bo-b$tail\nBonana-fanna fo-f$tail\nFee fi mo-m$tail\n$name!";
}
