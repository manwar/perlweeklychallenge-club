#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( combinations ) ;

sub myRule {
  my $array = shift ;
  return ($array->[0] < $array->[2]) && ( $array->[2] < $array->[1] ) ;
}

say "Enter a list of integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @allCombis ;
my $iter = combinations( \@numbers , 3 ) ;
while ( my $c = $iter->next ) {
  if ( myRule( $c ) ) {
      push @allCombis , $c ;
  }
}
if ( scalar( @allCombis ) > 0 ) {
  say "(" . join( ',' , @{$allCombis[0]} ) . ")" ;
}
else {
  say "()" ;
}
