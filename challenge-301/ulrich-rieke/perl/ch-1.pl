#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( permutations ) ;
use List::Util qw ( max ) ;

say "Enter some integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ; 
my @numbers = split( /\s/ , $line ) ;
my $total ;
my @allTotals ;
my $iter = permutations( \@numbers ) ;
while ( my $c = $iter->next ) {
   map { $total .= $_ } @$c ;
   push( @allTotals , $total ) ;
   $total = ( ) ;
}
say max( @allTotals ) ;
