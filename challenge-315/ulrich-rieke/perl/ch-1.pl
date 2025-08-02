#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a sentence!" ;
my $line = <STDIN> ;
chomp $line ;
say "Enter a character!" ;
my $char = <STDIN> ;
chomp $char ;
my @solution ;
my $pos = 0 ;
for my $word ( split( /\s+/ , $line ) ) {
   if ( $word =~ /$char/ ) {
      push @solution , $pos ;
   }
   $pos++ ;
}
say '(' . join( ',' , @solution ) . ')' ;
