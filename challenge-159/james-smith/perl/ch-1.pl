#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

say join ', ', farley( $_ ) for 1..10;

sub farley {
  my($n,%v) = shift;
  for my $d (1..$n) {
    $v{$_/$d}||="$_/$d" for 1..$d;
  }
  map{$v{$_}}sort{$a<=>$b}keys%v;
}

