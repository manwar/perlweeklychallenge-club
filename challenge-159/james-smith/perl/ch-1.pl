#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

 (say join ', ', farley(        $_ )),
  say join ', ', farley_simple( $_ ) for 1..10;
cmpthese( 1000, {
  'x' => sub { farley(        $_ ) for 1..20; },
  'y' => sub { farley_simple( $_ ) for 1..20; },
});

sub farley {
  my %v;
  for my $d (1..$_[0]) {
    $v{$_/$d}||="$_/$d" for 1..$d;
  }
  map{$v{$_}}sort{$a<=>$b}keys%v;
}

sub farley_simple {
  my($b,$a,$d,@v)=my($c,$k,$n)=(1,0,shift);
  ( $a, $b, $c,                         $d      ) =
  ( $c, $d, ($k=int(($n+$b)/$d))*$c-$a, $k*$d-$b), push @v, "$a/$b" while $c<$n;
  @v;
}

