#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( iso('abc','xyz'), 1 );
is( iso('abb','xyy'), 1 );
is( iso('sum','add'), 0 );
is( iso('add','sum'), 0 );

done_testing( );

sub iso {
  my ($a,$b) = @_;
  my %x;
  my %y;
  return 0 unless length $a == length $b;
  my @b = split m{}, $b;
  foreach ( split m{}, $a ) {
    my $t = shift @b;
    if( exists $x{$_} ) { ## Have we already got a map from 1st letter?
      return 0 unless $x{$_} eq $t; ## Yes but it doesn't match return...
    } else {
      $x{$_} = $t;
      return 0 if exists $y{$t} && $y{$t} ne $_;
    }
    $y{$t} = $_;
  }
  return 1;
}

