#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( zip ) ;

say "Enter some integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
my @before_pairs = zip [0..$len - 1] ,  [@numbers] ;
my @sorted = sort { $a <=> $b } @numbers ;
my @after_pairs = zip [0..$len - 1] , [@sorted] ;
my @changed_indices ;
for my $pos (0..$len - 1) {
   if ( $before_pairs[$pos]->[1] != $after_pairs[$pos]->[1] ) {
      push( @changed_indices , $pos ) ;
   }
}
say '(' . join( ',' , @changed_indices ) . ')' ;
