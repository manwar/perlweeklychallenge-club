#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);

sub comp_sm {
  my( $f, $g ) = @_;
  sub { $f->( $g->( @_ ) ); };
}

sub compose {
  my($g,$f) = pop;
  @_ && ($f = pop) ? compose( @_, sub { $f->($g->(@_)) } ) : $g
}

my($e,$f,$g,$h)=(sub{-20+pop},sub{2*pop},sub{10+pop},sub{pop()/7});


my($ys,$xr,$yr)=(comp_sm($h,comp_sm($g,my$xs=comp_sm($f,$e))),
  compose($f,$e),compose($h,$g,$f,$e));

## 22 - 20 = 2 .. * 2 = 4 .. + 10 = 14 .. / 7 = 2

printf '

  Compose simple:
    2-functions: 4 == %d
    4-fucntions: 2 == %d

  Compose recursive:
    2-functions: 4 == %d
    4-functions: 2 == %d

', map { $_->(22) } $xs, $ys, $xr, $yr;
