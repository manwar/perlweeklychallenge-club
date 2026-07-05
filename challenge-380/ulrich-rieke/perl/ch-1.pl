#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max ) ;

say "Enter a word consisting of English letters only!" ;
my $word = <STDIN> ;
chomp $word ;
my $vowels = "aeiouAEIOU" ;
my %vowelcount ;
my %consocount ;
for my $letter ( split( // , $word ) ) {
   if ( index( $vowels , $letter ) != -1 ) {
      $vowelcount{$letter}++ ;
   }
   else {
      $consocount{$letter}++ ;
   }
}
my $consomax = 0 ;
my $vowelmax = 0 ;
if ( %vowelcount ) {
   $vowelmax += max( values( %vowelcount ) ) ;
}
if ( %consocount ) {
   $consomax += max( values( %consocount )) ;
}
say ( $vowelmax + $consomax ) ;
