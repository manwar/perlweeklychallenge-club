#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a line of single digits, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
my @sorted = sort { $b <=> $a } @numbers ;
if ( scalar @sorted == scalar ( grep { $_ % 2 == 1 } @sorted ) ) {
  say "An even number can't be formed!" ;
  exit( 1 ) ;
}
my $len = scalar @sorted ;
my $i = $len ;
do {
  --$i ;
} while ( not ( $sorted[ $i ] % 2 == 0 ) ) ;
my $smallestEven = $sorted[ $i ] ;
splice( @sorted , $i , 1 ) ;
push( @sorted , $smallestEven ) ;
say join( '' , @sorted ) ;
