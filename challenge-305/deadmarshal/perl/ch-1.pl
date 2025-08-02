#!/usr/bin/env perl
use strict;
use warnings;
use Math::Prime::Util qw(is_prime);
use Data::Show;

sub binary_prefix{
  my ($arr) = @_;
  my ($bin,@res) = ('');
  map{$bin .= $_; push @res,is_prime(oct("0b$bin")) ? 1 : 0} @$arr;
  @res
}

print show binary_prefix([1,0,1]);
print show binary_prefix([1,1,0]);
print show binary_prefix([1,1,1,1,0,1,0,0,0,0,1,0,1,0,0,1,0,0,0,1]);

