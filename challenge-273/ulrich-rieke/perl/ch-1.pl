#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use POSIX ;

say "Enter a word!" ;
my $word = <STDIN> ;
chomp $word ;
say "Enter a character!" ;
my $character = <STDIN> ;
chomp $character ;
my $percentage =  (scalar ( grep { $_ eq $character } split( 
	       // , $word ) ) / length $word ) * 100  ;
if ( $percentage - floor( $percentage ) > 0.4 ) {
   say floor( $percentage ) + 1 ;
}
else {
   say floor( $percentage ) ;
}
