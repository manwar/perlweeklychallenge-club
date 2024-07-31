#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub createPair {
   my $word = shift ;
   my @pair ;
   if ( $word =~ /^(\D+)(\d+)$/ ) {
      push( @pair , $1 , $2 ) ;
   }
   return @pair ;
}

say "Enter some words, ended by numbers!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s/ , $line ) ;
my @allPairs ;
for my $w ( @words ) {
   my @pair = createPair( $w ) ;
   push ( @allPairs , \@pair ) ;
}
my @sorted = sort { $a->[1] <=> $b->[1] } @allPairs ;
my @firsts = map { $_->[0] } @sorted ;
say join( ' ' , @firsts ) ;

