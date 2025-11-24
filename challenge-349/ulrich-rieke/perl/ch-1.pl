#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a word!" ;
my $word = <STDIN> ;
chomp $word ;
my $lastChar = substr( $word , 0 , 1 ) ;
my $count = 1 ;
my @frequencies ;
for my $c ( split( // , substr( $word , 1 ) ) ) {
   if ( $c eq $lastChar ) {
       $count++ ;
   }
   else {
       my @ar = ( $lastChar , $count ) ;
       push( @frequencies , \@ar ) ;
       $count = 1 ;
       $lastChar = $c ;
   }
}
my @ar = ($lastChar , $count ) ;
push( @frequencies , \@ar ) ;
my @sorted = sort { $b->[1] <=> $a->[1] } @frequencies ;
say $sorted[0]->[1] ;

