#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max ) ;

say "Enter some height differences as integers separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
my $currentHeight = 0 ;
my @heights = (0) ;
for my $n ( @numbers ) {
   $currentHeight += $n ;
   push( @heights , $currentHeight ) ;
}
say max( @heights ) ;
