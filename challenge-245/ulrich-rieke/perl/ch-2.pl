#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( permutations combinations ) ;

sub concatenate {
   my $numbers = shift ;
   my $concat ;
   map { $concat .= $_ } @$numbers ;
   return $concat ;
}

say "Enter some numbers greater than 0 , separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $iter = permutations( \@numbers ) ;
my @permuted ;
while ( my $c = $iter->next ) {
   push @permuted , concatenate( $c ) ;
}
my @selected = grep { $_ % 3 == 0 } @permuted ;
if ( @selected ) {
   my @sorted = sort { $b <=> $a } @selected ;
   say $sorted[ 0 ] ;
}
else {
   my $len = scalar( @numbers ) ;
   my $i = $len ;
   my @sorted ;
   while ( $i != 1 ) {
      @permuted = ( ) ;
      $iter = combinations( \@numbers , $i ) ;
      while ( my $c = $iter->next ) {
	 my @combi = @$c ;
	 my $permuiter = permutations( \@combi ) ;
	 while ( my $permuc = $permuiter->next ) {
	    push @permuted , concatenate( $permuc ) ;
	 }
      }
      @selected = grep { $_ % 3 == 0 } @permuted ;
      if ( @selected ) {
	 @sorted = sort { $b <=> $a } @selected ;
	 last ;
      }
      else {
	 $i-- ;
      }
   }
   if ( @selected ) {
      say $sorted[0] ;
   }
   else {
      say "-1" ;
   }
}
