#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub convert {
   my $pair = shift ;
   my $word = $pair->[1] ;
   if ( $word =~ /^[AEIOUaeiou]/ ) {
      $word .= "ma" ;
   }
   else {
      $word = ( substr( $word , 1 ) . substr( $word , 0 , 1 ) . "ma" ) ;
   }
   $word .= "a" x ( $pair->[0] + 1 ) ;
   return $word ;
}

say "Enter a sentence!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s+/ , $line ) ;
my @wordIndices ;
for my $i (0.. scalar( @words ) - 1 ) {
   push( @wordIndices, [$i , $words[$i]] ) ;
}
my @result = map { convert( $_ ) } @wordIndices ;
say join( ' ' , @result) ;
