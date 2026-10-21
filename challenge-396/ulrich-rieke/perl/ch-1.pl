#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub find {
   my $array = shift ;
   my $element = shift ;
   for my $part( @$array ) {
      if ( $part->[1] == $element ) {
         return $part ;
      }
   }
}

say "Enter n integers from 1 to n in any order!" ;
my $line = <STDIN> ;
chomp $line ;
my @order = split( /\s/ , $line ) ;
say "Enter a subset of these integers in strictly ascending order!" ;
$line = <STDIN> ;
chomp( $line ) ;
my @friends = split( /\s/ , $line ) ;
my $l = scalar( @order ) ;
my @letterpositions ;
for my $pos( 0..$l - 1 ) {
   push( @letterpositions , [$pos , $order[$pos]] ) ;
}
my @selected ;
for my $f ( @friends ) {
   push( @selected , find( \@letterpositions , $f )) ;
}
my @sorted = sort { $a->[0] <=> $b->[0] } @selected ;
my @solution = map { $_->[1] } @sorted ;
say '(' . join( ',' , @solution ) . ')' ;


