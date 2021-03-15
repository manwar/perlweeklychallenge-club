#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is(cc('THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG',3),'QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD','example 1');
is(cc('QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD',-3),'THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG','example 2');
is(cc('A QUICK MOVEMENT OF THE ENEMY WILL JEOPARDIZE SIX GUNBOATS',13),'N DHVPX ZBIRZRAG BS GUR RARZL JVYY WRBCNEQVMR FVK THAOBNGF','example 3');

sub cc {
  my $s=shift;
  my $n=shift;
  my @plain=('A'..'Z');
  my @cipher=(@plain,@plain);
  splice @cipher,0,(26*2-$n)%26;
  my %m=map {$plain[$_] => $cipher[$_]} (0..$#plain);
  return join('',map {$m{$_} || $_} split '',$s);
}
