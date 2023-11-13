#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( combinations ) ;

say "Enter at least 3 integers in increasing order!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
say "Enter a positive number!" ;
my $diff = <STDIN> ;
chomp $diff ;
my $result = 0 ;
my @indices = (0..scalar( @numbers ) - 1) ;
my $iter = combinations( \@indices , 3 ) ;
while ( my $c = $iter->next ) {
   if ( ($numbers[ $c->[1] ] - $numbers[ $c->[0] ] == $diff) 
	 && ($numbers[ $c->[2] ] - $numbers[ $c->[1] ] == $diff ) ) {
      $result++ ;
   }
}
say $result ;

