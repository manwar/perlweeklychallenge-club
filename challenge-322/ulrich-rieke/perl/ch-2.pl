#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( zip ) ;

say "Enter some integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my %numhash ;
map { $numhash{$_}++ } @numbers ;
my @zipped = zip [1..scalar( keys %numhash)] , [sort { $a <=> $b } keys 
 %numhash ] ;
my @solution ;
for my $n ( @numbers ) {
   push( @solution , map { $_->[0] } grep { $_->[1] == $n } @zipped ) ;
}
say '(' . join( ',' , @solution ) . ')' ;
