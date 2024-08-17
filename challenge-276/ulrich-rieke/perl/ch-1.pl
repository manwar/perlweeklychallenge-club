#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( combinations ) ;

say "Enter some positive integers , separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
my $total = 0 ;
my $iter = combinations( \@numbers , 2 ) ;
while ( my $c = $iter->next ) {
   if ( ($c->[0] + $c->[1]) % 24 == 0 ) {
      $total++ ;
   }
}
say $total ;
