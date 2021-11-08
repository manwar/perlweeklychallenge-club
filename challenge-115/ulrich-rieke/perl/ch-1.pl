#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter strings, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @strings = split( /\s+/ , $line ) ;
my %startletters ;
my %endletters ;
for my $string ( @strings ) {
  $startletters{ substr( $string , 0 , 1 ) }++ ;
  $endletters{ substr( $string , length( $string) - 1 , 1 ) }++ ;
}
for my $key ( keys %startletters ) {
  if ( not exists $endletters{ $key } ) {
      say 0 ;
      exit( 0 ) ;
  }
  if ( $startletters{ $key } != $endletters{ $key } ) {
      say 0 ;
      exit( 0 ) ;
  }
}
say 1 ;
