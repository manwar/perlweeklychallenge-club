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

my $f1 = sub { $_[0]-20 };
my $f2 = sub { $_[0]*2  };
my $f3 = sub { $_[0]+10 };
my $f4 = sub { $_[0]/7  };
my $x_s = comp_sm( $f2, $f1 );
my $x_r = compose( $f2, $f1 );
my $y_s = comp_sm( $f4, comp_sm( $f3, comp_sm( $f2, $f1 ) ) );
my $y_r = compose( $f4, $f3, $f2, $f1 );

## 22 - 20 = 2 .. * 2 = 4 .. + 10 = 14 .. / 7 = 2

say '';
say 'Compose simple';
say '  2-functions: 4 == ',$x_s->(22);
say '  4-functions: 2 == ',$y_s->(22);
say '';
say 'Compose recursive';
say '  2-functions: 4 == ',$x_r->(22);
say '  4-functions: 2 == ',$y_r->(22);
say '';
