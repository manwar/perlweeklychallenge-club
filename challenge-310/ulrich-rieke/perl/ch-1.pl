#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers separated by blanks!" ;
say "Enter <return> to end!" ;
my $line = <STDIN> ;
chomp $line ;
my @numberarray ;
while ( $line ) {
   my @numbers = split( /\s/ , $line ) ;
   push( @numberarray , \@numbers ) ;
   $line = <STDIN> ;
   chomp $line ;
}
my %common ;
map {$common{$_}++} @{$numberarray[0]} ;
my $len = scalar( @numberarray ) ;
for my $pos (1 .. $len - 1 ) {
   my %uniques ;
   map { $uniques{$_}++ } @{$numberarray[$pos]} ;
   for my $key( keys (%common) ) {
      unless( exists( $uniques{$key} ) ) {
	 delete( $common{$key} ) ;
      }
   }
}
say '(' . join( ',' , sort { $a <=> $b } keys( %common ) ) . ')' ;
