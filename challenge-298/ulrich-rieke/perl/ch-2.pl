#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( min ) ;

sub find {
   my $array = shift ;
   my $element = shift ;
   my $pos = 0 ;
   while ( $array->[$pos] != $element ) {
      $pos++ ;
   }
   return $pos ;
}

say "Enter some integers , separated by whitespace!" ;
say "Every first , third and so on should be unique!" ;
my $line = <STDIN> ;
chomp $line ; 
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
my @pairs ;
my $current = 0 ;
while ( $current < $len - 1 ) {
   my @curPair = ( $numbers[$current] , $numbers[$current + 1 ] ) ;
   push( @pairs , \@curPair ) ;
   $current += 2 ;
}
my @solution ;
for my $i (0..scalar( @pairs ) - 1 ) {
   my @selected = grep { $_->[0] >= $pairs[$i]->[1] } @pairs ;
   my @starts = map { $_->[0] } @selected ;
   if ( @starts ) {
      my $mini = min( @starts ) ;
      my @first_elements = map { $_->[0] } @pairs ;
      my $pos = find( \@first_elements , $mini ) ;
      push( @solution, $pos ) ;
   }
   else {
      push( @solution , -1 ) ;
   }
}
say "(" . join( ',' , @solution ) . ")" ;

