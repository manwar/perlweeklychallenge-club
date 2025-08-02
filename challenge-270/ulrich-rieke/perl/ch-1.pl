#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum ) ; 

#we enter an array. The number we look for is the smaller of the number of
#rows containing only one 1 and the number of columns containing only one 1
say "Enter some 0 and 1 separated by blanks!" ;
say "Enter <return> to end entry!" ;
my @matrix ;
my $line = <STDIN> ;
chomp $line ;
while ( length $line > 0 ) {
   my @numbers = split( /\s+/ , $line ) ;
   push( @matrix , \@numbers ) ;
   $line = <STDIN> ;
   chomp( $line ) ;
}
my $validRows = 0 ;
for my $row( 0..scalar( @matrix ) - 1 ) {
   if ( sum( @{$matrix[$row]} ) == 1 ) {
      $validRows++ ;
   }
}
my $validColumns = 0 ;
for my $col( 0..scalar( @{$matrix[0]} ) - 1 ) {
   my @transposed ;
   for my $row( 0..scalar( @matrix ) - 1 ) {
      my $elt = $matrix[$row]->[$col] ;
      push( @transposed, $elt ) ;
   }
   if ( sum( @transposed ) == 1 ) {
      $validColumns++ ;
   }
}
if ( $validRows < $validColumns ) {
   say $validRows ;
}
else {
   say $validColumns ;
}

