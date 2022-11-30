#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( variations_with_repetition ) ;

my $n = $ARGV[0] ;
my @seeder = ( 0 , 1 ) ;
my @combis ;
my $iter = variations_with_repetition( \@seeder , $n ) ;
while ( my $p = $iter->next( )) {
  push @combis, $p ;
}
for my $combi( @combis ) {
  print join( '' , @$combi ) ;
  unless ( $combi == $combis[-1] ) {
      print ", " ;
  }
}
say " " ;
