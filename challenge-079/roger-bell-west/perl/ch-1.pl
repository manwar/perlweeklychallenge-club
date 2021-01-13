#! /usr/bin/perl

use strict;
use warnings;

use Math::GMPz qw( :mpz );

use Test::More tests => 2;

is(csb(4),5,'example 1');
is(csb(3),4,'example 2');

sub csb {
  my $tot=shift;
  my $n=Math::GMPz->new(1);
  my $bits=Math::GMPz->new(0);
  my $m=Math::GMPz->new(1000000007);
  while ($n <= $tot) {
    Rmpz_add_ui($bits,$bits,Rmpz_popcount(Math::GMPz->new($n)));
    Rmpz_mod($bits,$bits,$m);
    Rmpz_add_ui($n,$n,1);
  }
  return Rmpz_get_str($bits,10);
}
