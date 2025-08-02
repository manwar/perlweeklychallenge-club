#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

my @allWords ;
my $fh ;
open ( $fh , "< Challenge286.pl")  or die "can't open file!" ;
my @lines = <$fh> ;
close( $fh ) ;
for my $line( @lines ) {
   if ( $line ) {
      my @words = split( /\s+/ , $line ) ;
      map { push( @allWords , $_ ) } @words ;
   }
}
my $len = scalar( @allWords  ) ;
srand( time( )) ;
my $pos = int( rand( $len ) ) ;
say $allWords[ $pos ] ;
