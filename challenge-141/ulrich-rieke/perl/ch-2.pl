#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( combinations ) ;

my $m = $ARGV[ 0 ] ;
my $n = $ARGV[ 1 ] ;
my @numbers = split( // , $m ) ;
my @digits = @numbers ;
my $len = scalar( @numbers ) ;
if ( $len > 2 ) {
  for my $l ( 2 .. $len - 1 ) {
      my $iter = combinations( \@digits , $l ) ;
      while ( my $c = $iter->next ) {
    push @numbers , join( '' , @$c ) ;
      }
  }
}
say ( scalar ( grep { $_ % $n == 0 } @numbers )) ;
