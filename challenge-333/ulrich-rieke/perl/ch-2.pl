#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
my @after_doubling ;
my $len = scalar( @numbers ) ;
for my $n ( @numbers ) {
   if ( $n == 0 ) {
      push( @after_doubling , 0 ) ;
      push( @after_doubling , 0 ) ;
   }
   else {
      push( @after_doubling , $n ) ;
   }
}
say join( ',' , @after_doubling[0..$len - 1] ) ;
