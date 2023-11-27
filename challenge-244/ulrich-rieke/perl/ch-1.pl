#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers , separated by blanks" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @solution ;
my $len = scalar( @numbers ) ;
for my $index (0..$len - 1 ) {
   my @selected = grep { $_ < $numbers[ $index ] } @numbers ;
   push @solution , scalar( @selected ) ;
}
say "(" . join( ',' , @solution ) . ")" ;
