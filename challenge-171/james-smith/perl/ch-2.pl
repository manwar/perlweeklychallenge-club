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
  @_ && ($f = pop) ? compose( @_, sub { $f->($g->(@_)) } ) : $g;
}

my $x_r = compose( sub { $_[0]*2 }, sub { $_[0]-20 }  );
my $x_s = comp_sm( sub { $_[0]*2 }, sub { $_[0]-20 }  );

my $y_r = compose( sub { $_[0]/7 }, sub { $_[0]+10 },
                 sub { $_[0]*2 }, sub { $_[0]-20 }  );
my $y_s = comp_sm( sub { $_[0]/7 }, comp_sm( sub { $_[0]+10 }, $x_s ) );

say '';
say 'Compose simple';
say '  2-functions: 4 == ',$x_s->(22);
say '  4-functions: 2 == ',$y_s->(22);
say '';
say 'Compose recursive';
say '  2-functions: 4 == ',$x_r->(22);
say '  4-functions: 2 == ',$y_r->(22);
say '';
