#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( zip ) ;

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
say "Enter some indices into the integer array!" ;
$line = <STDIN> ;
chomp $line ;
my @indices = split( /\s+/ , $line ) ;
my @pairs = zip( \@numbers , \@indices ) ;
my @target ;
for my $p ( @pairs ) {
   if ( scalar( @target ) == 0 ) {
      push( @target , $numbers[ 0 ] ) ;
   }
   else {
      splice( @target , $p->[1] , 0 , $p->[0] ) ;
   }
}
print "(" ;
print join (',' , @target ) ;
say ")" ;
