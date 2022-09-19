#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

my $f = sub {
  my $num1 = shift ;
  return 5 * $num1 ;
} ;

my $g = sub {
  my $num2 = shift ;
  return sqrt( $num2 ) ;
} ;

sub compose {
  my ( $func1 , $func2 ) = @_ ;
  return sub {
      my $num = shift ;
      &$func2( &$func1( $num ) ) ;
  }
}

my $h = &compose( $f , $g ) ;
say $h->(6) ;
