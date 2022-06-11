#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [1234,5678], 7 ],
  [ [5678,1234], 3 ],
);
is( fibnum(       @{$_->[0]} ), $_->[1] ) foreach @TESTS;
is( fibnum_nasty( @{$_->[0]} ), $_->[1] ) foreach @TESTS;
is( fibnum_messy( @{$_->[0]} ), $_->[1] ) foreach @TESTS;

done_testing();

sub fibnum_messy {
  ($a,$b)=@_;$b=$a.($a=$b)while 51>length$b;substr$b,50,1;
}

sub fibnum_nasty {
  my ($r,$s) = @_;
  $s=$r.($r=$s) while 51>length $s;
  substr $s,50,1;
}
sub fibnum {
  my ( $r, $s ) = @_;
  ( $r, $s ) = ( $s, $r.$s ) while 51 > length $s;
  substr $s, 50, 1;
}
