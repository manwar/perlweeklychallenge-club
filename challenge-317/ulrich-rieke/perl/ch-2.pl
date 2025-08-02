#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( zip ) ;

say "Enter 2 strings separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s+/ , $line ) ;
if ( length ( $words[0] ) != length( $words[1] ) ) {
   say "false" ;
}
else {
#we zip the 2 words letter by letter. If the condition is fulfilled
#there should be only 2 pairs of nonequal letters in reverse order of
#each other!
   my @zipped = zip [split(// , $words[0])] , [split(// , $words[1])] ;
   my @different = grep { $_->[0] ne $_->[1] } @zipped ;
   if ( scalar( @different ) == 2 && $different[0]->[0] eq 
	 $different[1]->[1] && $different[0]->[1] eq $different[1]->[0] ) {
      say "true" ;
   }
   else {
      say "false" ;
   }
}
