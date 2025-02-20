#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( combinations ) ;
use List::Util qw ( min ) ;

say "Enter some integers separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $iter = combinations( \@numbers , 2 ) ;
my @differences ;
while ( my $c = $iter->next ) {
   push( @differences , abs( $c->[0] - $c->[1] ) ) ;
}
say min( @differences ) ;
