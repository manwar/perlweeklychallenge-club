#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max ) ;

sub find_length {
   my $numbers = shift ;
   my $index = shift ;
   my %set ;
   while ( not ( exists( $set{$numbers->[$index]} ) ) ) {
      $set{$numbers->[$index]}++ ;
      $index = $numbers->[$index] ;
   }
   return scalar( keys( %set ) ) ;
}

say "Enter a permutation of integers 0..n - 1!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
my @lengths ;
for my $i (0..$len - 1 ) {
   push( @lengths , find_length( \@numbers , $i ) ) ;
}
say max( @lengths ) ;
