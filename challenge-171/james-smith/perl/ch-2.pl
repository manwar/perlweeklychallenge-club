#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);

sub comp_sm {
  my($f,$g) = @_;
  return sub { &$f( &$g( @_ ) ); };
}

sub compose {
  my $g = pop; return $g unless @_;
  my $f = pop; compose( @_, sub { &$f(&$g(@_)) } );
}

my $x = compose( sub { $_[0]*2 }, sub { $_[0]-20 }  );
my $z = comp_sm( sub { $_[0]*2 }, sub { $_[0]-20 }  );

my $y = compose( sub { $_[0]/7 }, sub { $_[0]+10 },
                 sub { $_[0]*2 }, sub { $_[0]-20 }  );
my $y0 = comp_sm( sub { $_[0]/7 }, comp_sm( sub { $_[0]+10 }, $z ) );

say "X: ",$x->(22);
say "Z: ",$z->(22);
say "Y: ",$y->(22);
say "Y: ",$y0->(22);

